#Draw one shape based in relative node points.
#===Options
#
#* <tt>:x and :y</tt> - Initial position.
#* <tt>:content</tt> - Facade to ShapeContent with same parameters.
#* <tt>:border</tt> - Facade to Border with same parameters.
#===Examples
# 
# doc.polygon :x => 3.5, :y => 5.5 do
#   node :x => 4,  :y => 0
#   node :x => 0,  :y => -4
#   node :x => -4, :y => 0
#   node :x => 0,  :y => 4
# end
#
#link:images/polygon01.png
#
# doc.polygon :x => 3.5, :y => 4.5 do
#   node :x => 2,  :y => 2
#   node :x => 2,  :y => -2
#   node :x => -2, :y => -2
# end
#
#link:images/polygon02.png
#
# doc.polygon :x => 1, :y => 5, :border => {:width => 2, :linejoin => 1} do
#   node :x => 2,  :y => 2/2
#   node :x => 2*2,:y => -2
#   node :x => -1, :y => -3
#   node :x => 2,  :y => 1
#   node :x => 3,  :y => 2
# end
#
#link:images/polygon03.png
class RGhost::Polygon < RGhost::PsObject
  attr_reader :points
  
  DEFAULT_OPTIONS={
    :x => :limit_left,
    :y => :current_row,
    :content => RGhost::ShapeContent::DEFAULT_OPTIONS,
    :border =>  RGhost::Border::DEFAULT_OPTIONS
    
    
  }
  def initialize(options={},&block)
    super(''){}
    
    @options = DEFAULT_OPTIONS.dup.merge(options)
    @points=[] 
    instance_eval(&block) if block
  end
  #Creates new relative point by :x => 2 and :y => 4. Used as instance_eval
  def node(point)
    @points << point
  end
  
  def ps
    graph=RGhost::Graphic.new 
    graph.set RGhost::Cursor.moveto(@options)
    graph.set RGhost::Border.new(@options[:border]) if @options[:border]
    
    @points.each{|p|  graph.set RGhost::Line.rlineto(p) }
    
    graph.raw :closepath
    #graph.raw :gsave
    graph.set RGhost::ShapeContent.new(@options[:content]) if @options[:content]
    #graph.raw :grestore
    graph.raw :stroke
    graph
        
    
  end
  
end
