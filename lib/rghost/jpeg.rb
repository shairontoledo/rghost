require "rghost/ps_object"
require "rghost/graphic"
require "rghost/cursor"
require "rghost/variable"
require "rghost/image"
  #Loads JPEG image from file
  #===Examples
  # doc=Document.new
  # doc.set Jpeg.new "../public/images/button.jpg", :x => 10, :y => 3
  #Using Image.for facade 
  # doc.set Image.for "../public/images/button.jpg", :x => 10, :y => 3
  #Using PsFacade or Document 
  # doc.image "images/button.jpg", :x => 10, :y => 3
  #Using Zoom of the 200 percent
  # doc.image "images/button.jpg", :zoom => 200
  #===Options
  #
  #* <tt>:x and :y</tt> - Coordinates to position.
  #* <tt>:rotate</tt> - Angle to image rotation if there is one.
  #* <tt>:zoom</tt> - Resize proportionally the image
class RGhost::Jpeg < RGhost::Image



  def ps
    #x=Units::parse( @options[:x] )
    #y=Units::parse( @options[:y] )
    
    g=RGhost::Graphic.new 
    g.set RGhost::Cursor.translate(@options)
      #set Cursor.translate()
    g.set RGhost::Cursor.rotate(@options[:rotate])
    g.set RGhost::Variable.new(:zoom,@options[:zoom]/100.0)
    g.set RGhost::PsObject.new("(#{@file}) viewJPEG")
    g.ps

  end

end
