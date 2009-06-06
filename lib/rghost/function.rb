require "rghost/ps_object"


#Creates postscript internal function. Example
# f=RGhost::Function.new :foo do
#  set Show.new("A Test")
# end  
#In ps stack will be
# /foo (A Test) show def
class RGhost::Function < RGhost::PsObject

  attr_reader :name

  def initialize(name,body_function=nil,&block)
    if block
      #super(&block)
      super(&block)
        
    else
        
      super("")
    end  
    @name=name
    @body_function=body_function

  end
  
  def use_template(function_name)
    call "_#{function_name}"
   
  end
  def ps
    @body_function||=super
      
    "\n/#{@name}{\n#{@body_function}\n} bind def \n"
  end

end
