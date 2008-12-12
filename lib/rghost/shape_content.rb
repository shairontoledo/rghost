#Responsible for fill shapes
class RGhost::ShapeContent < RGhost::PsObject

  DEFAULT_OPTIONS={
    :fill => true, :color => "#F0FFFF"
    
  }
  #You can use parameter :color(facade for Color.create) or disable using :fill => false
  def initialize(options={})
    super(""){}
    @options = DEFAULT_OPTIONS.dup.merge(options)
  end
  
  def ps
    p=RGhost::PsObject.new
    p.raw :gsave
    p.set RGhost::Color.create(@options[:color])  if @options[:color]
    p.raw :fill if @options[:fill]
    p.raw :grestore
    p
  end
  
end
