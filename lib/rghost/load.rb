require "rghost/ps_object"
module RGhost::Load
  #Loads library
  def self.library(name, type=:ps)
    #PsObject.new File.open(File.dirname(__FILE__)+File::SEPARATOR+type.to_s+File::SEPARATOR+name.to_s+"."+type.to_s).readlines.join("")
    
   RGhost::PsObject.new("(#{name.to_s}.#{type}) runlibfile\n")
      
  end
  
  def self.rg_enviroment
    RGhost::PsObject.new do
      raw RGhost::Load.library(:basic)
      raw RGhost::Load.library(:cursor)
      raw RGhost::Load.library(:rectangle)
      raw RGhost::Load.library(:font)
      raw RGhost::Load.library(:textarea)
      raw RGhost::Load.library(:horizontal_line)
      raw RGhost::Load.library(:vertical_line)
      raw RGhost::Load.library(:callbacks)
      raw RGhost::Load.library(:show)
      raw RGhost::Load.library(:eps)
      raw RGhost::Load.library(:jpeg)
      raw RGhost::Load.library(:gif)
      raw RGhost::Load.library(:begin_document)
      raw RGhost::Load.library(:datagrid)
      raw RGhost::Load.library(:text)
      raw RGhost::Load.library(:frame)
      raw RGhost::Load.library(:link)
      raw RGhost::Load.library(:rect_link)
      
    end
  end
  #Loads binary library
  def self.binary(path)
      File.open(path).readlines.join
  
  end
  

  
end

