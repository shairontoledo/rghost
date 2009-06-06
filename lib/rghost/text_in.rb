require "rghost/ps_object"
require "rghost/cursor"
require "rghost/ruby_to_ps"
#TextIn is a helper to combine the cursor positioning and text output into one step.
class RGhost::TextIn < RGhost::PsObject
  include RGhost::RubyToPs
  DEFAULT_OPTIONS={:x=> :limit_left,:y=> :current_row, :tag => :default_font, :write => "Ruby Ghost API - current_row = %row% "}
  #===Options
  #* <tt>:x and :y</tt> - Initial position.
  #* <tt>:tag or :with</tt> - Use predefined tag.
  #* <tt>:color</tt> - Override color of the tag.
  #* <tt>:text or :write</tt> - The text.
  #===Examples
  # doc=RGhost::Document.new
  # doc.text_in :x => 3, :y => 4, :write => "Foo Bar Baz", :tag => :h1
  #====Rotating
  # doc.newpath do
  #  translate :x => 3, :y=> 4
  #   rotate 45
  #   text_in :x => 0, :y => 0, :write => "Foo Bar Baz1", :tag => :font2
  # end
  #====Eval postscript internal
  #TextIn will eval postscript internal variables you pass in between % signs. Sounds complex, huh?  Let's see an example:
  # doc.text_in :x=> 3.5, :y=> 5.5, :text => "this is %row% row and current page %current_page%"
  def initialize(options={})
    
    @options=DEFAULT_OPTIONS.dup.merge(options)
  end
  
  def ps
    text=RGhost::PsObject.new
    text.set RGhost::Cursor.moveto(@options)
    #text.raw "currentfont"
    #text.raw "currentrgbcolor"
    text.raw RGhost::Color.create(@options[:color])  if @options[:color]
    f="_#{@options[:with] || @options[:tag] || :default_font}"
    text.raw f
    #text.call @options[:with] || @options[:tag]  || :default_font
    
    text.raw string_eval(@options[:text] || @options[:write] )
    #text.raw "setrgbcolor"
    #text.raw "setfont"
    text.graphic_scope
    #text.set PsObject.new(@options[:text])
   
   
    
    
  end
  
end