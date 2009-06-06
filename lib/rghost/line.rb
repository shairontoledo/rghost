require "rghost/ps_object"
require "rghost/point"

#Creates straight lines 
class RGhost::Line < RGhost::PsObject
  DEFAULT_POINT={:x => :limit_left , :y => :current_row}
  
  #Draw line the one pont until another, the first point is creates by moveto and de last point using the method lineto.
  #===Examples
  # doc=Document.new
  # doc.moveto :x => 2, :y => 3
  # doc.lineto :x => 5, :y => 2
  # 
  #link:images/line01.png 
  #
  # doc=Document.new
  # doc.moveto :x => 2, :y => 3
  # doc.lineto :x => 4, :y => 4 
  # 
  #link:images/line02.png 
  #
  # doc=Document.new
  # doc.border :color => '#AAFA49', :width => 4
  # doc.moveto :x => 2, :y => 3
  # doc.lineto :x => 4, :y => 1 
  # 
  #link:images/line03.png 
  #
  # doc=Document.new
  # doc.border :color => '#49AAFA', :width => 1
  # doc.moveto :x => 2, :y => 3
  # doc.lineto :x => 4, :y => 1 
  # doc.moveto :x => 2, :y => 3
  # doc.lineto :x => 2, :y => 1 
  # 
  #link:images/line04.png 
  #
  #Using graphic state to close path shape
  #
  # doc=Document.new
  # doc.graphic do
  #   doc.border :color => '#49AAFA', :width => 1
  #   doc.moveto :x => 2, :y => 3
  #   doc.lineto :x => 4, :y => 1 
  #   doc.lineto :x => 2, :y => 1 
  #   doc.shape_content :color => "#F0FFFF"
  #   doc.closepath
  # end
  # 
  #link:images/line05.png 
  def self.lineto(point={})
  
    RGhost::Line.make_command(:lineto,point)
  
  end
  #(Relative lineto) Draw straingh line in the same manner as lineto, but from current point to distance for next :x and :y. That is, rlineto constructs a line from (x, y) to (x + dx, y + dy) and makes (x + dx, y + dy) the new current point. 
  #
  #===Examples
  # doc=Document.new
  # doc.moveto  :x => 2, :y => 1
  # doc.rlineto :x => 3, :y => 2
  # 
  #link:images/line06.png 
  #
  # doc=Document.new
  # doc.moveto  :x => 2, :y => 1
  # doc.rlineto :x => 3, :y => 2
  # doc.rlineto :x => 0, :y => -2
  #link:images/line07.png 
  def self.rlineto(point={})
    line=RGhost::Line.make_command(:rlineto,point)
  
  end
  
  
  private 
  def self.make_command(command,point={})

    p=DEFAULT_POINT.dup.merge(point)
    p=RGhost::Point.new(p[:x],p[:y])
    RGhost::PsObject.new "#{p.ps}#{command}"
  end
  
end





