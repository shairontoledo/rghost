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
class RGhost::Frame < RGhost::PsObject
  DEFAULT_OPTIONS={
    :x => :limit_left,
    :y => :current_row,
    :width => 5,
    :height => 3.5,
    :corners => 1,
    :content => RGhost::ShapeContent::DEFAULT_OPTIONS,
    :border => RGhost::Border::DEFAULT_OPTIONS,
    :stroke => true
    
    
  }
  BACKGROUND_ROW_DEFAULT_OPTIONS={:start_in => :limit_left, :size => :area_x, :color => RGhost::ShapeContent::DEFAULT_OPTIONS[:color]}
  def initialize(options={})

    @options = DEFAULT_OPTIONS.dup.merge(options)

  end
  
  
  def ps
    x=RGhost::Units::parse(@options[:x])
    y=RGhost::Units::parse(@options[:y])
    
    h=RGhost::Units::parse(@options[:height])
    w=RGhost::Units::parse(@options[:width])
    
    inside=RGhost::ShapeContent.new(@options[:content]) if @options[:content]
    border=RGhost::Border.new(@options[:border]) if @options[:border]
    
    params=%Q{
    /rcorners_params{
    /:x #{x}   def /:y #{y} def
    /:w #{w} def /:h #{h} def
    /:r #{@options[:corners]} def
    /:s 1 def
    /:stk {#{ "stroke" if @options[:stroke]} }def 
    /:inside{
      #{inside.ps if inside }
    } def
    /:outside{
      #{border.ps if border}
    }def
      } def
    }
    
    "#{params} rcorners_params rcorners"
    
  end
  #Creates background of the row for current row. Example
  #Here's fill the current row using width :area_x, height :row_height, and starting in :limit_left.
  # doc.background_row :color => '#35F6A3'
  # 
  #link:images/background_row01.png
  #
  #Specifies size and where will start of background
  # doc.background_row :start_in => 2, :size => 5.5, :color => 0.8
  #
  #link:images/background_row02.png
  def self.background_row(options=BACKGROUND_ROW_DEFAULT_OPTIONS)
    #opts=BACKGROUND_ROW_DEFAULT_OPTIONS.merge(options)
    #start_in,size=Units::parse(opts[:start_in]),Units::parse(opts[:size])
    #return RGhost::PsObject.new("#{start_in} #{size} {#{opts[:color]}} background_row ")
    options =RGhost::Frame::BACKGROUND_ROW_DEFAULT_OPTIONS.merge(options)
    g=RGhost::Graphic.new
    g.set RGhost::Units::parse(options[:start_in])
    g.set RGhost::Units::parse(options[:size])
    g.set RGhost::Color.create(options[:color])  if options[:color]
    g.raw :background_row
    g
    
    
  end
end
