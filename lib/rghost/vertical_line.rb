require "rghost/ps_object"
require "rghost/units"
require "rghost/load"

#Creates vertical line starting from current row. 
class RGhost::VerticalLine < RGhost::PsObject
  DEFAULT_OPTIONS={
    :start_in=>:limit_left,:size=>:area_y,
    :border => RGhost::Border::DEFAULT_OPTIONS
  }
  #Draws a vertical line where :start_in => y position and :size => size of line.
  #===Example
  # doc=Document.new
  # doc.vertical_line :start_in => 1, :size => 2, :border => {:color => :red}
  def initialize(options=RGhost::Border::DEFAULT_OPTIONS)
    super(""){}
    options=DEFAULT_OPTIONS.dup.merge(options)
    start_in= RGhost::Units::parse(options[:start_in] || :limit_left)
    size= RGhost::Units::parse(options[:size]|| :area_y)
    g=RGhost::Graphic.new
    g.set RGhost::Border.new(options[:border]) if options[:border]
    g.raw "#{start_in} #{size} vertical_line "
    set g
  end
  #Draws a vertical line with size or :row_height of the document.
  #  doc=Document.new
  #  doc.vertical_line_row
  def self.row(border=RGhost::Border::DEFAULT_OPTIONS)
    
    g=RGhost::Graphic.new
    g.set RGhost::Border.new(border)
    g.raw :vlrf
    g
  end
  
end

