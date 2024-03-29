require "rghost/ps_object"
require "rghost/cursor"
require "rghost/point"
require "rghost/line_width"

# Initializes the current path to be empty, causing the current point to become undefined.
class RGhost::NewPath < RGhost::PsObject
  def initialize(&)
    @body = RGhost::PsFacade.new(&)
  end

  def ps
    "newpath #{@body} closepath"
  end
end
