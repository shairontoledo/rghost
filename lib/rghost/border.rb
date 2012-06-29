#Border object render a border around of vector shapes. Its sketch can be a combination of color, dashes, line joins and line caps.
#Usually its use inside of object facades, such as, Document, CallbackFacade and PsFacade as parameter :border, for example:
#  d=Document.new
#  d.horizontal_line :middle, :border => { :color => '#058412', :dash => [1,0,2] }
#You can use it as a new instance of Border and set inside of Document by method set, example:
#  d=Document.new
#  b=Border.new :color => '#058412', :dash => [1,0,2]
#  d.set b
#  d.lineto :x => 2.5, :y => 5
#===Options
#* <tt>:color</tt> - Facade to Color using the same parameter.
#* <tt>:dash</tt> - Facade to Dash using the same parameter.
#* <tt>:width</tt> - Facade to LineWidth using the same parameter.
#* <tt>:linejoin</tt> - Sets the line join parameter in the graphics state to int, which must be one of the integers 0, 1, or 2. 
#====:linejoin examples
#* <tt>Miter join</tt> link:images/linejoin0.png <tt> :linejoin => 0 </tt>
#* <tt>Round join</tt> link:images/linejoin1.png <tt> :linejoin => 1 </tt>
#* <tt>Bevel join</tt> link:images/linejoin2.png <tt> :linejoin => 2 </tt>
#* <tt>:linecap</tt> - Sets the line cap parameter in the graphics state to int, which must be one of the integers 0, 1, or 2
#====:linecap examples
#* <tt><tt>Butt cap</tt></tt> link:images/linecap0.png <tt> :linecap => 0 </tt>
#* <tt>Round cap</tt> link:images/linecap1.png <tt> :linecap => 1 </tt>
#* <tt>Projecting square cap</tt> link:images/linecap2.png <tt> :linecap => 2 </tt>
class RGhost::Border < RGhost::PsObject

  DEFAULT_OPTIONS = {:color => '#49AAFA', :dash => false, :width => 0.5, :linejoin => 0, :linecap => 0  }
  
  def initialize(options={})
    super(""){}
    @options = DEFAULT_OPTIONS.dup.merge(options)
  end

  def ps #:nodoc:
    p=RGhost::PsObject.new
    p.set RGhost::LineWidth.new(@options[:width]) if @options[:width]
    p.raw "#{@options[:linejoin]} setlinejoin"
    p.raw "#{@options[:linecap]} setlinecap"
    p.set RGhost::Dash.new(@options[:dash])       if @options[:dash]
    p.set RGhost::Color.create(@options[:color])  if @options[:color]
    p
  end
 
end

