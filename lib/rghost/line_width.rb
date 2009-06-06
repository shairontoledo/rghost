require "rghost/ps_object"
#Sets the line width parameter in the graphics state.
class RGhost::LineWidth < RGhost::PsObject
  
  #Examples
  #The more tiny line
  # doc=Document.new
  # doc.line_width 0 
  #
  #link:images/line_width01.png 
  #
  # doc.line_width 1 
  #
  #link:images/line_width02.png 
  #
  # doc.line_width 2 
  #
  #link:images/line_width03.png 
  #
  def initialize(value=0.3)
    @value=value
  end 
  
  def ps
    "#{@value} setlinewidth "
  end

end
