require "ps_object"
require "cursor"
require "color"
require "point"
require "point"
require "line_width"
#Creates a new graphic state between gsave and grestore postscript primitives. Example
#   doc=Document.new
#   doc.graphic do
#     set LineWidth.new(0)
#     set Line.lineto(5,7)
#   end
class RGhost::Graphic < RGhost::PsObject
  
  def ps
      "gsave #{super} grestore"
  end
  
  
end



 




