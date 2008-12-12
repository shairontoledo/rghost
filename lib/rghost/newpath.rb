require "ps_object"
require "cursor"
require "color"
require "point"
require "point"
require "line_width"

#Initializes the current path to be empty, causing the current point to become undefined. 
class RGhost::NewPath < RGhost::PsObject
 
  def initialize(&block)
    @body=RGhost::PsFacade.new(&block)
    
  end
  
  def ps
      "newpath #{@body} closepath"
  end
  
  
end