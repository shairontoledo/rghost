require "rghost/ps_object"
require "rghost/ruby_to_ps"  #to_string

#Writes a text on the current row or point with align.
class RGhost::Show < RGhost::PsObject
  
  attr_accessor :text, :align, :tag
  DEFAULT_OPTIONS={:tag => :default_font, :align => :show_left}
  include RGhost::RubyToPs
  #===Options
  #
  #* <tt>:tag or :with</tt> - Use predefined tag
  #* <tt>:color</tt> - Override color of the tag
  #* <tt>:align</tt> - Align of the text
  #===Examples
  #The vertical line is the current point. For align by point
  # doc.moveto :x => 3, :y => 4
  # doc.show "Foo Bar Baz", :align => :show_left      #default
  #link:images/show01.png 
  #
  # doc.moveto :x => 3, :y => 4
  # doc.show "Foo Bar Baz", :align => :show_center 
  #link:images/show02.png 
  #
  # doc.moveto :x => 3, :y => 4
  # doc.show "Foo Bar Baz", :align => :show_right
  #link:images/show03.png 
  #
  #For the the current row it's not necessary positioned using moveto. Like below
  # doc.show "Foo Bar Baz", :align => :show_right
  #Now justification in page
  #
  # doc.show "Foo Bar Baz", :align => :page_left     
  # 
  #link:images/show04.png 
  #
  # doc.show "Foo Bar Baz", :align => :page_center 
  # 
  #link:images/show05.png 
  #
  # doc.show "Foo Bar Baz", :align => :page_right
  # 
  #link:images/show06.png 
  #
  #====Overrinding tag's color 
  #
  # doc.show "Foo Bar Baz", :with => :my_italic, :align => :page_center, :color => :red 
  # 
  #link:images/show07.png 
  #
  #Many tags per row
  #  doc=Document.new
  #  doc.define_tags do
  #    tag :font1, :name => 'Helvetica', :size => 10, :color => '#F34811' 
  #    tag :font2, :name => 'Times',     :size => 14, :color => '#A4297A' 
  #    tag :font3, :name => 'TimesBold', :size => 18, :color => '#AA3903' 
  #  end
  #
  #  doc.show "foo bar baz ",  :with => :font1
  #  doc.show "qux quux ",     :with => :font2
  #  doc.show "corge ",        :with => :font3
  #  doc.show "grault garply ",:with => :font2
  #  doc.show "qux quux",      :with => :font1
  #
  #link:images/show08.png 
  

  
  def initialize(text,options={ :align=>:show_left, :tag => :default_font, :color => 0 } )
    @text = text
    @options=DEFAULT_OPTIONS.dup.merge(options)
  end
  
  def ps
    rtext=RGhost::PsObject.new
    #rtext.raw Color.create(@options[:color] || 0) 
    if @options[:with] || @options[:tag]
      f="_#{@options[:with] || @options[:tag]}"
      rtext.raw f 
    end
    rtext.raw RGhost::Color.create(@options[:color])  if @options[:color]
    rtext.raw to_string(@text)
    rtext.raw @options[:align]
    
    rtext.graphic_scope
  end

end
