require "rghost/ps_object"
require "rghost/units"
#Draw a circle to the current path(or current row by default).
#===Options
#
#* <tt>:x and :y</tt> - as center of the circle.
#* <tt>:radius</tt> - as radius(in points).
#* <tt>:ang1</tt> - the angle of a vector from (:x , :y ) of length :radius to the first endpoint of the circle.
#* <tt>:ang2</tt> - the angle of a vector from (:x, :y) of length :radius to the second endpoint of the circle.
#* <tt>:content</tt> - facade to ShapeContent with same parameters.
#* <tt>:border</tt> - facade to Border with same parameters.
#* <tt>:use</tt> - <b>:arc</b> draw counterclockwise and <b>:arcn</b> (arc negative) clockwise direction. 
#===Examples using facade circle method inside of Document
#  d=Document.new
#  d.circle :x => 5, :y => 2.5 , :radius => 40
#
#link:images/circle01.png
#  d=Document.new
#  d.circle :x => 5, :y => 2.5 , :radius => 40, :content => {:fill => false}
#
#link:images/circle02.png
# 
#  d=Document.new
#  d.circle :x => 5, :y => 2.5 , :radius => 40, :content => {:color => "#FF0000"} 
#
#link:images/circle03.png
# 
#  d=Document.new
#  d.circle :x => 5, :y => 2.5 , :radius => 40, :content => {:color => "#FF0000"} ,:border => {:color => "#FFFFFF"}
#
#link:images/circle04.png
#  
#  d=Document.new
#  d.circle :x => 5, :y => 2.5 , :radius => 40, :content => {:color => :yellow} ,:border => {:color => :orange, :dash => [1,2,1,2], :width => 20}
#
#link:images/circle05.png
# 
#   d=Document.new
#   colors=%w[#98AE09 #AFE099 #A971FF #CC1010 #FF7201 #34FEE1]
#   6.downto(1) do |v|
#     d.circle :x => 5, :y => 2.5 , :radius => v*10, :content =>{:color => colors[v]}
#   end
#   
#link:images/circle06.png
# d=Document.new
# d.circle :x => 5, :y => 2.5 , :ang1 => 90, :radius => 50, :content => {:fill => false }   
#    
#link:images/circle07.png
# 
# d=Document.new
# d.circle :x => 5, :y => 2.5 , :ang2 => 90, :radius => 50, :content => {:fill => false }   
#    
#link:images/circle08.png
# 
# d=Document.new
# d.circle :x => 5, :y => 2.5 , :ang2 => 90, :radius => 50, :content =>{:color => :green}
#    
#link:images/circle09.png
#
# d=Document.new
# d.circle :x => 5, :y => 2.5 , :ang2 => 90, :use => :arcn, :radius => 50, :content =>{:color => :green}
#    
#link:images/circle10.png
#
#===Examples using Circle class
#   d=Document.new 
#   d.scale(3,1)
#   d.set Circle.new(:x => 1.5, :y => 1.5 , :ang2 => 180, :radius => 25)
#
#link:images/circle11.png
class RGhost::Circle < RGhost::PsObject
  DEFAULT_OPTIONS={
    :x => :limit_left,
    :y=> :current_row,
    :radius => 50, 
    :ang1 => 0, 
    :ang2 => 360 , 
    :use => :arc, 
    :content => RGhost::ShapeContent::DEFAULT_OPTIONS,
    :border =>  RGhost::Border::DEFAULT_OPTIONS
    }
  
  def initialize(options={})
    super(''){}
      @options=DEFAULT_OPTIONS.dup.merge(options)
  end
 
  def ps
    
    x,y= RGhost::Units::parse(@options[:x]), RGhost::Units::parse(@options[:y]) #with parse
    
    graph=RGhost::Graphic.new
    graph.raw :newpath
    graph.set RGhost::Border.new(@options[:border]) if @options[:border]
    graph.raw  "#{x} #{y} #{@options[:radius]} #{@options[:ang1]} #{@options[:ang2]} #{@options[:use]} " 
    graph.set RGhost::ShapeContent.new(@options[:content]) if @options[:content]
    graph.raw :stroke
    graph

  end

end
