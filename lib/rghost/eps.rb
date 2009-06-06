require "rghost/ps_object"
#Load new EPS file.
class RGhost::Eps < RGhost::PsObject
  #===Examples
  # doc=Document.new
  # doc.set Eps.new "/local/templates/myform.eps", :x => 10, :y => 3
  #Using Image.for facade 
  # doc.set Image.for "/local/templates/myform.eps", :x => 10, :y => 3
  #Using PsFacade or Document 
  # doc.image "/local/templates/myform.eps", :x => 10, :y => 3
  #===Options
  #
  #* <tt>:x and :y</tt> - Coordinates to position.
  #* <tt>:rotate</tt> - Angle to image rotation if there is one.
  def initialize(eps_path,options={:x=>0, :y=> 0, :rotate => 0})
    super("")
    @options=options
    @path=eps_path
  end
  
  
  def ps
    
    "BeginEPSF \n #{RGhost::Cursor.translate(@options)} \n\t(#{@path}) run \nEndEPSF\n ";

  end
  
  

  
end
