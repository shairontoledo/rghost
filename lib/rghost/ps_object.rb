#Postscript wrapper class
class RGhost::PsObject
  
  #Creates new instance of PsObject. Example
  #   PsObject.new("/my_proc { 33 45 2 10 sub mul div} bind def") 
  #Or by block code
  #   PsObject.new do
  #     set PsObject.new("(A test) show")
  #     raw "(Other Test in raw) show "
  #   end
  def initialize(body="",&block)
    @body=if body.is_a? RGhost::PsObject
      body.ps
    else
      "#{body} "
    end
    
    instance_eval(&block) if block
    
  end
  #Alias for ps.
  def to_s
    ps
  end
  #Gets postscript code.
  def ps
    @body.to_s
  end
  #Pushes elements on the stack.
  def raw(*value)
    @body << "#{value.join(' ')} "
  end 
  #Freezes graphic state
  def graphic_scope
    "beging #{self} endg "
  end
  #Sets PsObject into this object.
  def set(value)

    raise TypeError.new("can't convert #{value.class} into PsObject") unless value.is_a? RGhost::PsObject
    @body << "#{value.ps} "
    value
  end
  #Alias for set
  def <<(value)
    set value
   
  end
  
  #Call operator in the stack
  def call(name)
    set RGhost::PsObject.new(name)
  end  
   
end