$LOAD_PATH << File.dirname(__FILE__)+File::SEPARATOR+"../"

require 'rghost/ps_object'

require 'rghost/ruby_to_ps'

module RGhost::Grid 
  module FieldFormat 
    extend RGhost::RubyToPs
    #Format Time/Date to %d/%m/%Y
    def self.eurodate(value)
   
      string(value.strftime("%d/%m/%Y"))
    end
    #Cut all blank spaces
    def self.no_space(value)
      string(value.to_s.gsub(/\s/,''))
    end
    
    def self.string(value)
      to_string(value)
    end  
   
  end
end
#Prototype to override format method.
class RGhost::Grid::FieldFormat::Custom 
   
  def initialize(value)
    @value=value
  end
   
  def gs_format
    RGhost::Grid::FieldFormat.string(self.format)
  end 

  def format
    @value.to_s
  end
   
end


