require "rghost/ps_object"
require "rghost/units"
require "rghost/font"
require "rghost/ruby_to_ps"
#Wraps the text so as the it fits on the page(:area_x). Wrapping happens at whitespace characters without hyphenation. 
#Additionally you can make use of predefined tag and the special tag <br/> to break row. You can disable the parse with second parameter tag_parse=false.
#===Examples
#  doc=Document.new
#  doc.define_tags do
#    tag :font1, :name => 'Helvetica', :size => 10, :color => '#F34811' 
#    tag :font2, :name => 'Times',     :size => 11, :color => '#A4297A' 
#    tag :font3, :name => 'TimesBold', :size => 12, :color => '#AA3903' 
#  end
#  my_text="<font1>foo, bar, baz</font1>,<font2>qux, quux</font2>, corge, grault, garply, waldo, <font3>fred, plugh,</font3> xyzzy,<br/> thud, bing" 
#  doc.text my_text
#  
#link:images/text01.png 
#
#===Without parse
#  text="<font1>foo, bar, baz</font1>,<font2>qux, quux</font2>, corge, grault, garply, waldo, <font3>fred, plugh,</font3> xyzzy,<br/> thud, bing" 
#  doc.text text,false
#
#link:images/text02.png 
class RGhost::Text < RGhost::PsObject
  include RGhost::RubyToPs
  include RGhost::ParseText
  attr_reader  :rows
  
  def initialize(text,tag_parse=true)
    super("")
    @text=text
    @tag_parse=tag_parse
    @options={:text_align => :left}
  end

  def ps
    text_to_ps #from RGhost::ParseText
  end
  



end

