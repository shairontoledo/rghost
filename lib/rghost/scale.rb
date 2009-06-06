require "rghost/ps_object"
#Scales objects

class RGhost::Scale < RGhost::PsObject
  #===Examples
  # doc.scale(1,1)      #default document scale
  #
  #link:images/scale01.png
  #
  # doc.scale(1,3)
  #
  #link:images/scale02.png
  #
  # doc.scale(3,3)
  #
  #link:images/scale03.png
  def initialize(sx,sy)
    super("#{sx} #{sy} scale")
  end
  #Scale proportionally by value in percent
  #===Example
  # doc.zoom(300)   # 300% the same that scale(3,3)
  def self.zoom(value=100)
    
    RGhost::Scale.new(value/100.0,value/100.0)
  
  end

end