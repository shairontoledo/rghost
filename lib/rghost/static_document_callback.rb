require "rghost/ps_object"
require 'rghost/function'

class RGhost::StaticDocumentCallback < RGhost::Function #:nodoc:
  ACCEPT=[:before_document_create,
          :first_page,
          :last_page,
          :after_document_create 
  ]  
  
  def initialize(name,&block)
    raise NameError.new("#{name} no accept in #{self.class}") unless ACCEPT.include? name
    super(name,&block)
  end
    

end

