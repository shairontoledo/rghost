require "rghost/ps_object"
#Super class of GIF and JPEG.
class RGhost::Image < RGhost::PsObject
  DEFAULT_OPTIONS={:x=> :limit_left, :y=> 1, :zoom => 100, :rotate => 0}
  
  def initialize(image_path,options={})
    super("")
    @options=DEFAULT_OPTIONS.dup.merge(options)
    @file=image_path
  end
  
  #Facade method for load image by file extension. Uses Eps, Gif and Jpeg class. Accepts gif, jpeg, jpg and eps
  def self.for(path,options={})
    
    clazz=case path
      when /gif$/i
        RGhost::Gif
      when /jpe?g$/i
        RGhost::Jpeg
      when /(eps|template)$/i
          RGhost::Eps
      else raise NameError.new("Unsupported format")
    end
    
    clazz.new(path,options)
  end
  
  
end  
