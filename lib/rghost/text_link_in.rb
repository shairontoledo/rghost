require "rghost/ps_object"
require "rghost/cursor"
require "rghost/ruby_to_ps"
#TextLinkIn is a helper to combine the cursor positioning and text with hyperlink output into one step as TextIn.
#It works only PDF format
class RGhost::TextLinkIn < RGhost::PsObject
  include RGhost::RubyToPs
  DEFAULT_OPTIONS={:x=> :limit_left,:y=> :current_row, :tag => :default_font, :color => :blue,:label => "RGhost API", :url => 'http://rghost.rubyforge.org'}
  #===Options
  #* <tt>:x and :y</tt> - Initial position.
  #* <tt>:tag or :with</tt> - Use predefined tag.
  #* <tt>:color</tt> - Override color of the tag.
  #* <tt>:label</tt> - The text.
  #* <tt>:url</tt> - Hyperlink.
  #===Examples
  # doc=RGhost::Document.new
  # doc.text_link "Shairon at Hashcode", :url => "http://www.hashcode.eti.br", :color => :blue,  :x => 3, :y => 4, :tag => :h1
  #====Rotating
  # doc.newpath do
  #  translate :x => 3, :y=> 4
  #   rotate 45
  #   text_link "RGhost website", :url => "http://rghost.rubyforge.org", :x => 0, :y => 0, :tag => :font2
  # end
  def initialize(options={})
    
    @options=DEFAULT_OPTIONS.dup.merge(options)
  end
  
  def ps
    text=RGhost::PsObject.new
    text.set RGhost::Cursor.moveto(@options)
    text.raw RGhost::Color.create(@options[:color])  if @options[:color]
    f="_#{@options[:with] || @options[:tag] || :default_font}"
    text.raw f
    text.raw "/:link_str #{to_string(@options[:label])} def /:link_uri #{to_string(@options[:url])} def :link_make "
    text.ps
   
   
    
  end
  
end