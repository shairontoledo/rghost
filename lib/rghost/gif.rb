require "rghost/ps_object"
require "rghost/graphic"
require "rghost/cursor"
require "rghost/variable"
require "rghost/image"
require "rghost/function"
require "rghost/scale"
  #Loads GIF image from file
  #===Examples
  # doc=Document.new
  # doc.set Gif.new "../public/images/button.gif", :x => 10, :y => 3
  #Using Image.for facade 
  # doc.set Image.for "../public/images/button.gif", :x => 10, :y => 3
  #Using PsFacade or Document 
  # doc.image "images/button.gif", :x => 10, :y => 3
  #Using zoom of the 200 percent
  # doc.image "images/button.gif", :zoom => 200
  #===Options
  #
  #* <tt>:x and :y</tt> - Coordinates to position.
  #* <tt>:rotate</tt> - Angle to image rotation if there is one.
  #* <tt>:zoom</tt> - Resize proportionally the image
class RGhost::Gif < RGhost::Image

  def ps
    s=@options[:zoom]/100.0
    
    g=RGhost::Graphic.new 
    
    params=RGhost::Function.new(:gif_params)
    params.set RGhost::Cursor.translate(@options)  
    params.set RGhost::Cursor.rotate(@options[:rotate])
    params.set RGhost::Scale.new(s,s) 
    
    g.set params
    g.set RGhost::PsObject.new("(#{@file}) viewGIF")  
    g.ps

  end

end
