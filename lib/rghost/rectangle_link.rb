#Creates one rectangle or one shape with rounded corners.
#===Options
#
#* <tt>:x and :y</tt> - Coordinates to position.
#* <tt>:corners</tt> - Value for rounded corners. Use 0 to straight angle.
#* <tt>:width and :height</tt> - Size of frame
#* <tt>:content</tt> - facade to ShapeContent with same parameters.
#* <tt>:border</tt> - facade to Border with same parameters.
#===Examples using facade frame method inside of Document
#  d=Document.new
#  d.frame :x => 3, :width => 7, :height => 5, :content => {:fill => false}
#
#link:images/frame01.png
#  d=Document.new
#  d.frame :x => 3, :width => 7, :height => 5, :content => {:color => '#35F6A3' }
#
#link:images/frame02.png
# 
#  d=Document.new
#  d.frame :x => 3, :width => 7, :height => 5, :content => {:color => '#35F6A3' }, :border =>{:width => 5, :dash => [1,3,10]}
#
#link:images/frame03.png
# 
#  d=Document.new
#  d.frame :x => 3, :width => 7, :height => 5, :content => {:color => '#35F6A3' }, :corners => 20
#
#link:images/frame04.png
#  
#  d=Document.new
#  d.frame :x => 3, :width => 7, :height => 5, :content => {:color => :yellow }, :border => {:color => :red, :width => 4}, :corners => 20
#  
#link:images/frame05.png
class RGhost::RectangleLink < RGhost::PsObject
	include RGhost::RubyToPs
  DEFAULT_OPTIONS={
    :x => :limit_left,
    :y => :current_row,
    :width => 5,
    :height => 3.5,
    :url => "http://rghost.rubyforge.org",
    :border_color => RGhost::Border::DEFAULT_OPTIONS[:color]
    
    
  }
  def initialize(options={})

    @options = DEFAULT_OPTIONS.dup.merge(options)

  end
  
  
  def ps
    x=RGhost::Units::parse(@options[:x])
    y=RGhost::Units::parse(@options[:y])
    
    h=RGhost::Units::parse(@options[:height])
    w=RGhost::Units::parse(@options[:width])
    url=@options[:url]
    scolor=RGhost::Color.create(@options[:border_color]).ps.gsub(/setrgbcolor/,'')
		"/:rect_color [#{scolor}] def /:rect_x #{x} def /:rect_y #{y} def /:rect_w #{w} def /:rect_h #{h} def /:rect_uri #{to_string(url)} def :rect_link"
    
    
  end
  
end
