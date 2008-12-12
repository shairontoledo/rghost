require "ps_object"
require "units"

class RGhost::PointWithCommand #:nodoc:
  DEFAULT_POINT={:x => :limit_left , :y => :current_row}

  def self.to(command,point={})
   
    p=DEFAULT_POINT.dup.merge(point)
   
    p=RGhost::Point.new(p[:x],p[:y])
    RGhost::PsObject.new "#{p.ps}#{command}"
  end
  
end


