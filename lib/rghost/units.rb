require "rghost/function"
require "rghost/ps_object"
#The postscript default unit is the 1/72th inch. RGhost uses the centimeters (cm) as it's default, mainly for positioning coordinates and numeric object sizes (if the size is a String, it won't be parsed to the default unit). This setting can be changed setting the value of RGhost::Config::GS[:unit] before the document is created using any of the Units child classes. 
#===Example:
#
#====Setting to inches.
# RGhost::Config::GS[:unit]=Units::Inch
# doc.moveto :x => 1, :y => 2  #=> 1 inch x 2 inches 
#====Explicitly setting to Cm.
# doc.moveto :x => '1 cm' , :y => '2 cm'
#====Using the Postscript unit 
# doc.moveto :x => '100' , :y => '200'
module RGhost::Units

  class Unit < RGhost::PsObject
  	
    attr_accessor :value
  
    def initialize(value=0)
      @value=value
    end
  
    def ps
  	
      "#{@value} #{self.class.to_s.gsub('RGhost::Units::','').downcase} "
    end
  
    def Unit.define
      ""
    end
  end
  #n/72 * 2.545
  class Cm < Unit
  	
    def Cm.define
      Function.new("cm","72 div 2.545 mul")
  		
    end
  
  end
  #n*72
  class Inch < Unit
  
    def Inch.define
      RGhost::Function.new("inch","72 mul")
    end
  
  end

  class PSUnit < Unit
  
    def ps
      "#{@value} "
    end
  
  end
  

  
  #Parses units
  # Units::DEFAULT=Utits::Cm
  # Units.parse(2)                #=> "2 cm"
  # Units.parse(:current_row)     #=> "current_row"
  # Units.parse("3 inch")         #=> "3 inch"
  # Units.parse("2")              #=> "2"
  # 
  #Using US metric
  #  Units::DEFAULT=Utits::Inch
  #  Units.parse(2)               #=> "2 inch"
  #  Units.parse(:current_row)    #=> "current_row"
  #  Units.parse("3 cm")          #=> "3 cm"
  #  Units.parse("5")             #=> "5"
  def self.parse(value)
    if value.is_a? Numeric
      RGhost::Config::GS[:unit].new(value)
    else
      RGhost::PsObject.new(value)
    end
  end
end


