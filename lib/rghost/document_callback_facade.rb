# This module is included inside of Document class. It will creates methods to easy the use.
#===Callback execution order
# Example for a document with 4 pages, looking at the picture you can see the order in which the callbacks are executed
#
# link:images/pages_rghost.png

module RGhost::DocumentCallbackFacade
  # Executes before page create. Respond to :only and :except options
  def before_page_create(options = {}, &)
    new_dynamic_callback(:before_page_create, options, &)
  end

  # Executes after page create. Respond to :only and :except options
  def after_page_create(options = {}, &)
    new_dynamic_callback(:after_page_create, options, &)
  end

  # Executes on odd pages create. Respond to :only and :except options
  def odd_pages(options = {}, &)
    new_dynamic_callback(:odd_pages, options, &)
  end

  # Executes on even pages create. Respond to :only and :except options
  def even_pages(options = {}, &)
    new_dynamic_callback(:even_pages, options, &)
  end

  # Executes one time before document create.
  def before_document_create(&)
    new_static_callback(:before_document_create, &)
  end

  # Executes one time on first page.
  def first_page(&)
    new_static_callback(:first_page, &)
  end

  # Executes one time on last page(end of document).
  def last_page(&)
    new_static_callback(:last_page, &)
  end

  # Executes before virtual page create. Respond to :only and :except options
  def before_virtual_page_create(options = {}, &)
    new_dynamic_callback(:before_virtual_page_create, options, &)
  end

  # Executes after virtual page create. Respond to :only and :except options
  def after_virtual_page_create(options = {}, &)
    new_dynamic_callback(:after_virtual_page_create, options, &)
  end

  private

  def new_dynamic_callback(name, options = {}, &)
    @callbacks.set RGhost::Callback.new(name, options, &)
  end

  def new_static_callback(name, &)
    callback_body = RGhost::PsFacade.new(&)
    @callbacks.set RGhost::Function.new(name, callback_body)
  end
end
