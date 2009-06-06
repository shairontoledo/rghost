require "rghost/ps_object"
require "rghost/units"
#Creates horizontal line on the current row.
class RGhost::HorizontalLine < RGhost::PsObject
  
  DEFAULT_OPTIONS={:start_in => :limit_left, :size => :area_x,
    :border => RGhost::Border::DEFAULT_OPTIONS
    
  }
 
#Examples
#
#Drawing line on middle
#
# doc.show "Foo Bar"
# doc.horizontal_line :middle
# 
#link:images/horizontal_line01.png
#
#Drawing line on bottom and customizing border attributes
#
# doc.show "Foo Bar"
# doc.horizontal_line :bottom, :border => {:dash => [1,2,2,2], :color => :red}
#
#link:images/horizontal_line02.png
#
#Specifies size and where will start of line
#
# doc.show "Foo Bar"
# doc.horizontal_line :top, :start_in => 2, :size => 5, :border => {:dash => [1,2,2,2], :color => :red}
#
#link:images/horizontal_line03.png

  
  def initialize(valign=:middle,options={})
    @options=DEFAULT_OPTIONS.dup.merge(options)
    start_in= RGhost::Units::parse(@options[:start_in])
    size= RGhost::Units::parse(@options[:size])
    border=RGhost::Border.new(@options[:border])
    super("gsave #{border.ps }  #{start_in} #{size} horizontal_line_#{valign} grestore")
    #super("#{start_in} #{size} horizontal_line_#{valign}")
  
  end
  
end
