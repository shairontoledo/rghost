require "rghost/ps_object"
require "rghost/ruby_to_ps"

# Callbacks are custom code blocks defined inside of Document. 
# All callbacks received implicitly a instance of PsFacade can be creates any PsObject.
# The callbacks's execution depend of the algorithims predefined in Postscript core library.
# There are two kind of callbacks, Statics and Dynamics callbacks.
# A Static callback there aren't parameters to control of the inclusion and exception on current scope, usually
# applied for events which happen one time, for example after_document_create, "after document create" always will execute one time for each document.
# Otherwise Dynamic callbacks there is control of scope using conditional :only or :except, this is only difference in relation the static callbacks.
# The parameters of a Dynamic callbak must be one integer or one array of integer. Example:
# For all pages except page 3
#  doc.before_page_create :except => 3 do |b|
#      # do something
#  end
# 
# For just 2 and 4 pages
#  doc.before_page_create :only => [2,4] do |b|
#      # do something
#  end
# 
# The most of callbacks are defined in facades such as DocumentCallbackFacade and Grid::CallbackFacade
class RGhost::Callback < RGhost::PsObject
  attr_accessor :only, :except, :name
  include RGhost::RubyToPs

  def initialize(name,options={},&block)
    
    super(""){}
    set RGhost::PsFacade.new(&block) if block
    @name=name
    @options=options
    
  end 
  
  def ps
    
    @only=num_to_array(@options[:only]) 
    @except=num_to_array(@options[:except])
  
    "\n/#{@name} 3 dict def #{@name} begin \n/proc { #{super} } bind def \n/except #{to_array(@except)} def \n/only #{to_array(@only)} def \nend "
    
  end

  private
  def num_to_array(value)
    case value
      when Fixnum then
        a=[]
        a << value
      when NilClass then []
      else
        value
    end
  
  end
end

