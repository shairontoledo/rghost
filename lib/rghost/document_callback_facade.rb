#This module is included inside of Document class. It will creates methods to easy the use.
#===Callback execution order
#Example for a document with 4 pages, looking at the picture you can see the order in which the callbacks are executed
#
#link:images/pages_rghost.png

module RGhost::DocumentCallbackFacade
  
  #Executes before page create. Respond to :only and :except options
    def before_page_create(options={},&block)
    new_dynamic_callback(:before_page_create,options,&block)
  end
  
  #Executes after page create. Respond to :only and :except options
  def after_page_create(options={},&block)
    new_dynamic_callback(:after_page_create,options,&block)
  end
  
  #Executes on odd pages create. Respond to :only and :except options
  def odd_pages(options={},&block)
    new_dynamic_callback(:odd_pages,options,&block)
  end
  
  #Executes on even pages create. Respond to :only and :except options
  def even_pages(options={},&block)
    new_dynamic_callback(:even_pages,options,&block)
  end
  
  #Executes one time before document create.
  def before_document_create(&block)
    new_static_callback(:before_document_create,&block)
  end
  
  #Executes one time on first page.
  def first_page(&block)
    new_static_callback(:first_page,&block)
  end
  #Executes one time on last page(end of document).
  def last_page(&block)
    new_static_callback(:last_page,&block)
  end
  
  #Executes before virtual page create. Respond to :only and :except options
  def before_virtual_page_create(options={},&block)
    new_dynamic_callback(:before_virtual_page_create,options,&block)
  end
  #Executes after virtual page create. Respond to :only and :except options
  def after_virtual_page_create(options={},&block)
    new_dynamic_callback(:after_virtual_page_create,options,&block)
  end
  
  private
  
  def new_dynamic_callback(name,options={},&block)
    @callbacks.set RGhost::Callback.new(name,options,&block)
  end
  def new_static_callback(name,&block)
    
    callback_body= RGhost::PsFacade.new(&block) 
    @callbacks.set RGhost::Function.new(name,callback_body)
  end
  
  
end
