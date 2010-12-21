[:ps_object, :dynamic_document_callback,:static_document_callback, :paper, :load,
:cursor,:show, :color, :graphic, :newpath, :line,  :parse_text,:line_width, :textarea, 
:variable, :eps, :jpeg, :gif, :text_in, :text_link_in, :ruby_ghost_engine, :convert,
:text, :dash, :border, :shape_content,  :vertical_line, :horizontal_line, 
:frame, :polygon, :circle, :how_to, :rectangle_link].each{|lib| require "rghost/#{lib}" }


#PsFacade is just a big facade involving an instance of most postscript objects.
class RGhost::PsFacade < RGhost::PsObject
  attr_reader :rows
  
  def initialize #(&block)
    super(""){}
    @rows=0
    yield self if block_given?
    #instance_eval(&block) if block
  end
  
  #A facade for the method Cursor.next_row
  def next_row
    @rows+=1
    set RGhost::Cursor.next_row
  end
  

  #Close path of the graphic state
  def closepath
    call :closepath
  end
  
  #A facade for the method Cursor.next_page
  def next_page
    set RGhost::Cursor.next_page
  end

  #A facade for the class Graphic
  def graphic(&block)
    psfc=RGhost::PsFacade.new
    yield psfc
    raw :gsave
    set psfc
    raw :grestore

  end

  #A facade for the class NewPath
  def newpath(&block)
    psfc=RGhost::PsFacade.new
    yield psfc
    raw :newpath
    set psfc
    raw :closepath
    #set RGhost::NewPath.new(&block)
  end

  #A facade for the method Cursor.showpage
  def showpage
    
    set RGhost::Cursor.showpage
    
  end
  #A facade for the class LineWidth
  def line_width(value=nil)
    set RGhost::LineWidth.new(value)
  end
  
  #A facade for the method Cursor.goto_row
  def goto_row(row)
    
    set RGhost::Cursor.goto_row(row)    
  end

  #A facade for the method Cursor.jump_rows
  def jump_rows(row)
    @rows+=row
    set RGhost::Cursor.jump_rows(row)
  end 
  
  #A facade for the method Cursor.rotate
  def rotate(angle) 
    set RGhost::Cursor.rotate(angle)
  end
  #A facade for the method Cursor.moveto
  def moveto(point={})
    set RGhost::Cursor.moveto(point)
  end
  
  #A facade for the method Cursor.rmoveto
  def rmoveto(point={})
    set RGhost::Cursor.rmoveto(point)
  end

  #A facade for the method Cursor.translate
  def translate(point={})
    set RGhost::Cursor.translate(point)
  end
   
  #A facade for the class DSCEntry
  def dsc_entry(&block)
    set RGhost::DSCEntry.new(&block)
  end
 
  #Use tag  after defined in define_tags
  def use_tag(tag_name)
    raw "_#{tag_name}"
  end
  
  #A facade for the class Image.for
  def image(path,options={})
    set RGhost::Image.for(path,options)
  end
  
  #alias horizontal_line
  def hl(valign=:middle,options={})
    set RGhost::HorizontalLine.new(valign,options)
  end
  
  #A facade for the class HorizontalLine
  def horizontal_line(valign=:middle,options={})
    hl(valign,options)
  end

  #A facade for the method Frame.background_row
  def background_row(options={})
    set RGhost::Frame.background_row(options)
  end
  
  #A facade for the class Scale
  def scale(sx,sy)
    set RGhost::Scale.new(sx,sy)
 
  end
  
  #A facade for the method Scale.zoom
  def zoom(percent)
    set RGhost::Scale.zoom(percent)
  end
  
  #A facade for the class TextIn
  def text_in(options={})
    set RGhost::TextIn.new(options)
  end
  
  #A facade for the class TextLinkIn
  def text_link(label,options={})
     options[:label]=label
    set RGhost::TextLinkIn.new(options)
  end
  
  #A facade for the class Text
  def text(text,tag_parse=true)
    set RGhost::Text.new(text.to_s,tag_parse)  
  end
    
  #A facade for the class Show
  def show(text,align={ :align=> :show_left })
    set RGhost::Show.new(text.to_s,align)  
  end
  
  def show_next_row(text,align={ :align=> :show_left })
    next_row
    show(text,align)
  end
  #Alias for show
  def write(text,align={ :align=> :show_left })
    show(text.to_s,align)  
  end
  #Allows call template after it definition.
  def use_template(name)
    call "_#{name}"
  end
  
  #Call internal function by name
  def use_function(name)
    call "_#{name}"
  end
  
  #A facade for the class TextArea
  def text_area(text,options={},tag_parse=true)
    ta=RGhost::TextArea.new(text,options,tag_parse)
    raw ta.ps
    ta
  end

  #A facade for the class VerticalLine
  def vertical_line(options={:start_in => :limit_left, :size => :area_y})
    set RGhost::VerticalLine.new(options)
  end
  
  #A facade for the method VerticalLine.row
  def vertical_line_row(border_options=RGhost::Border::DEFAULT_OPTIONS)
    set RGhost::VerticalLine.row(border_options)
  end
  
  #Forces draw shapes
  def stroke
    
    call :stroke
  end
 
  #A facade for the method Line.lineto
  def lineto(point={})
    set RGhost::Line.make_command(:lineto,point)
  end
  
  #A facade for the method Line.rlineto
  def rlineto(point={})
    set RGhost::Line.make_command(:rlineto,point)
  end

  #A facade for the class Dash
  def dash(options={})
    set RGhost::Dash.new(options)
  end
  
  #A facade for the method Color.create
  def color(options)
    set RGhost::Color.create(options)
  end
  
  #A facade for the class Border
  def border(options={})
    set RGhost::Border.new(options)
  end
  
  #A facade for the class ShapeContent
  def shape_content(options={})
    set RGhost::ShapeContent.new(options)
  end
  
  #A facade for the class Frame
  def frame(options)
    set RGhost::Frame.new(options)
  end
  #A facade for the class Polygon
  def polygon(options={},&block)
    set RGhost::Polygon.new(options,&block)
  end
  
  #A facade for the class Circle
  def circle(options={})
    set RGhost::Circle.new(options)
  end

  #A facade for the class RectangleLink
  def rectangle_link(options={})
    set RGhost::RectangleLink.new(options)
  end

  
end


