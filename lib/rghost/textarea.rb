require "rghost/ps_object"
require "rghost/units"
require "rghost/font"
require "rghost/ruby_to_ps"
require 'rghost/parse_text'
#TextArea wraps the text so as the it fits in a box of a given width. Wrapping happens at whitespace characters without hyphenation.
#Additionally you can make use of predefined tag and the special tag <br/> to break row. 
#The alignment can be left, right and centered.
#
#PS: It not jumps pages.

class RGhost::TextArea < RGhost::PsObject
  include RGhost::RubyToPs
  include RGhost::ParseText
  
  DEFAULT_OPTIONS={
    :width => :area_x,
    :row_height => :row_height,
    :x=> :limit_left,
    :y=> :current_row,
    :text_align => :left
   
  }

  #===Options
  #* <tt>:x and :y</tt> - Initial position.
  #* <tt>:row_height</tt> - Row height :)
  #* <tt>:with</tt> - Max wide of the text
  #* <tt>:text_align</tt> - Align of the text in the virtual box using :left, :right and :center.
  #===Examples
  # doc=RGhost::Document.new
  # my_text="<font1>foo, bar, baz</font1><font2>qux, quux</font2>, corge, grault, garply, waldo, <font3>fred, plugh,</font3> xyzzy,<br/> thud, bing"
  # doc.text_area my_text
  # 
  #link:images/text_area01.png 
  # 
  # doc.text_area my_text, :width =>3
  #
  #link:images/text_area02.png 
  #
  # doc.text_area my_text, :width =>3, :text_align => :center
  #
  #link:images/text_area03.png 
  #
  # doc.text_area my_text, :width =>3, :text_align => :right
  #
  #link:images/text_area04.png 
  #
  # doc.text_area my_text, :width =>3, :text_align => :right, :x => 3
  #
  #link:images/text_area05.png 
  #
  # doc.text_area my_text, :width =>3, :text_align => :right, :x => 3, :row_height => 0.6
  #
  #link:images/text_area06.png 
  
  def initialize(text,options={},tag_parse=true)
    super("")
    @text=text
    @tag_parse=tag_parse
    options||={}
    @options=DEFAULT_OPTIONS.dup.merge(options)
    
  end

  def ps
    bw=RGhost::Units::parse(@options[:width])
    ta=@options[:text_align]
    rh=RGhost::Units::parse(@options[:row_height])
    
    graph=RGhost::Graphic.new do
      set RGhost::Variable.new(':bw',bw)
      set RGhost::Variable.new('text_align',"/#{ta}")
      #      set Variable.new(':rp',rp)
      set RGhost::Variable.new(':rh',rh)
    end
    graph.set RGhost::Cursor.translate(@options) 
    graph.set RGhost::Cursor.moveto(:x => 0, :y =>0) 
    #graph.raw ":text_area #{text_to_ps} :text_proc"
    graph.raw text_to_ps
    graph
    #final_text=text_to_ps
    
  end
  
 
end

