require "rghost/ps_object"
#Creates Postscript variable
class RGhost::Variable < RGhost::PsObject
  
  #===Example
  #  v=Variable.new(:mytext, Show.new("Fooo Barrr") )
  #  doc.set v 
  def initialize(name,value)
    super("/#{name} #{value} def")
  end

end