#Sets the dash pattern on border lines. It accepts an array of
#non-negative numbers with atleast one non-zero. Samples:
# [2,1]     #=> 2 turn on and 1 off, 2 turn on and 1 off ...
# [3,1,2,5] #=> 3 on, 1 off, 2 on, 5 off ... repeating until end
# 
#
#===Examples using dash as border parameter
# d=Document.new
# d.horizontal_line(:bottom, :border=>{:dash => 1, :width => 2 }) 
#link:images/dash01.png
# 
# d=Document.new
# d.horizontal_line(:bottom, :border=>{:dash => [1,1], :width => 2 })
#link:images/dash01.png
# 
# d=Document.new
# d.horizontal_line(:bottom, :border=>{:dash => [1,2,1], :width => 2 })
#link:images/dash03.png
# 
# d=Document.new
# d.horizontal_line(:bottom, :border=>{:dash => [2,10,5], :width => 2 })
#link:images/dash04.png
# 
# d=Document.new
# d.horizontal_line(:bottom, :border=>{:dash => [1,1,3,1,5,1,7,1,9,1,10], :width => 4 })
#link:images/dash05.png
#
#===Examples using Dash class
# d=Document.new
# d.scale(1,8)
# d.set Dash.new([1,1,2,1,2,1,3])
# d.line_width 3
# d.lineto :x => :limit_right, :y => :Y
#link:images/dash06.png


class RGhost::Dash < RGhost::PsObject
  include RGhost::RubyToPs
  DEFAULT_OPTIONS={
    :style => [1,2,3],
    :offset => 0
  }
  
  def initialize(options={})
    super(""){}
    if options.is_a?(Numeric) || options.is_a?(Array)
      @options = DEFAULT_OPTIONS.dup.merge(:style => options)
    else
      @options = DEFAULT_OPTIONS.dup.merge(options)
    end
  end
  
  def ps
    ary=to_array( [@options[:style]].flatten)
    "#{ary}#{@options[:offset]} setdash"
  end
  
end
