require "rghost/callback" 

class RGhost::DynamicDocumentCallback < RGhost::Callback #:nodoc:
  ACCEPT=[:before_page_create,
    :after_page_create,
    :odd_pages,
    :even_pages
  ]  

  def initialize(name,options={},&block)
    raise NameError.new("#{name} no accept in #{self.class}") unless ACCEPT.include? name
    super(name,options,&block)
  end

end
