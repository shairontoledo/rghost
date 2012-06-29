require "rghost/ps_object"
require "rghost/constants"
require "rghost/ruby_to_ps" #array_to_stack

#Creates color for postscript components
class RGhost::Color < RGhost::PsObject
  
  include RGhost::RubyToPs
  #The method create is a color factory depends when parameter is used. The parameter variate between 0 and 1, if value greatet that 1 will be divided by 100.0 .
  #===Examples
  #====Creating RGB color
  #String HTML color converter
  # Color.create '#FFAA33'
  #As Symbol will be find in RGhost::Constants::Colors::RGB
  # Color.create :red         
  #As Array with 3 elements 
  # Color.create [0.5, 0.3, 0.5]
  #Hash with 3 pair of key/value. Valids keys :red, :green and :blue
  # Color.create :red => 0.5, :green => 0.3, :blue => 0.5 
  #Hash with 3 pair of key/value. Valids keys :r, :g and :b
  # Color.create :r => 0.5, :g => 0.3, :b => 0.5
  #====Creating CMYK color
  #Hash with 4 pair of key/value. Valids keys :cyan, :magenta, :yellow and :black
  #  Color.create :cyan=> 1 ,:magenta => 0.3, :yellow => 0, :black => 0 
  #Hash with 4 pair of key/value. Valids keys :c, :m, :y and :b
  #  Color.create :c=> 1 ,:m => 0.3, :y => 0, :b => 0
  #====Creating CMYK Spot color
  #Hash with 5 pair of key/value. Valids keys :cyan, :magenta, :yellow, :black, and :name
  #  Color.create :cyan=> 0, :magenta => 100, :yellow => 63, :black => 12, :name => 'Pantone 200 C'
  #====Creating Gray color
  #A single Numeric
  # Color.create 0.5
  #50 percent of black will be divided by 100.0
  # Color.create 50
  def self.create(color="FFAA99")
    
    return case color
    when String then RGhost::RGB.new(color)
    when Symbol then
        c=RGhost::Constants::Colors::RGB[color]
      raise ArgumentError.new("#{color}##{color.class}") unless c 
      self.create c
         
    when Array, Hash then
        if color.size == 3
        RGhost::RGB.new(color)
      elsif color.size == 4 
        RGhost::CMYK.new(color)
      elsif color.size == 5
        RGhost::CMYKSpot.new(color)
      else
        raise ArgumentError.new("#{color}##{color.class}")
      end
    when Numeric then RGhost::Gray.new(color)
    else
      raise ArgumentError.new("#{color}##{color.class}")
    end
  
  end

  
end

#Creates RGB color
class RGhost::RGB < RGhost::Color
  attr_accessor :red, :green, :blue
  CONSTANTS=RGhost::Constants::Colors::RGB
  DEFAULT_RGB={:red => 0, :green => 0, :blue => 0}
  #String HTML color converter
  # Color.create '#FFAA33'
  #As Symbol will be find in RGhost::Constants::Colors::RGB
  # Color.create :red         
  #As Array with 3 elements 
  # Color.create [0.5, 0.3, 0.5]
  #Hash with 3 pair of key/value. Valids keys :red, :green and :blue
  # Color.create :red => 0.5, :green => 0.3, :blue => 0.5 
  #Hash with 3 pair of key/value. Valids keys :r, :g and :b
  # Color.create :r => 0.5, :g => 0.3, :b => 0.5
  def initialize(color_or_red=nil,green=nil,blue=nil)
    @color=color_or_red
    @color=[color_or_red.to_f,green.to_f,blue.to_f] if color_or_red.is_a? Numeric
    @color=DEFAULT_RGB.merge(color_or_red) if color_or_red.is_a? Hash
    
  end
  
  def ps
		value=color_params
    
    array_to_stack(value.map{|n| n > 1 ? n/100.0: n})+"setrgbcolor"
  end
	def stack_format
		color_params
	end
	def color_params
    case @color
    when Hash then   [@color[:r] || @color[:red], @color[:g] || @color[:green],@color[:b] || @color[:blue]]
    when Array then  @color
    when String then hex_to_rgb(@color) 
    when NilClass then [0,0,1]
    end
		
		
  end
  
  def hex_to_rgb(color="#FFFFFF")
  
    color.gsub(/#/,'').scan(/[\dA-F]{2}/).map{|h| h.hex / 255.0}
  end

end

#Creates CMYK color space
class RGhost::CMYK < RGhost::Color
  attr_accessor :cyan ,:magenta, :yellow, :black
  CONSTANTS=RGhost::Constants::Colors::CMYK
  
  #Hash with 4 pair of key/value. Valids keys :cyan, :magenta, :yellow and :black
  #  Color.create :cyan=> 1 ,:magenta => 0.3, :yellow => 0, :black => 0 
  #Hash with 4 pair of key/value. Valids keys :c, :m, :y and :b
  #  Color.create :c=> 1 ,:m => 0.3, :y => 0, :b => 0
  def initialize(color={:cyan=> 1 ,:magenta => 0, :yellow => 0, :black => 0})
    @color=color
  end
  
  def ps
    value=case @color
      when Hash then  [@color[:c] || @color[:cyan],@color[:m] || @color[:magenta] ,@color[:y] || @color[:yellow], @color[:k] || @color[:black]]
      when Array then  @color
    end
    array_to_stack(value.map{|n| n > 1 ? n/100.0: n})+"setcmykcolor"
  end

end

#Creates CMYK Spot color space
class RGhost::CMYKSpot < RGhost::Color
  attr_accessor :cyan ,:magenta, :yellow, :black, :name

  def initialize(color={:name => 'spot', :cyan=> 1 ,:magenta => 0, :yellow => 0, :black => 0})
    @name = color[:name]
    color.delete(:name)
    @color = color
  end
  
  def ps
    value=case @color
      when Hash then  [@color[:c] || @color[:cyan],@color[:m] || @color[:magenta] ,@color[:y] || @color[:yellow], @color[:k] || @color[:black]]
      when Array then  @color
    end
    
    array_to_stack(value.map{|n| n > 1 ? n/100.0: n}) + "(#{@name.to_s}) findcmykcustomcolor \n/#{@name.to_s.gsub(' ', '_')} exch def\n\n#{@name.to_s.gsub(' ', '_')} 1 setcustomcolor"
  end
end

#Creates Gray color
class RGhost::Gray < RGhost::Color
  attr_accessor :gray
  
  #A single Numeric
  # Color.create 0.5
  #50 percent of black will be divided by 100.0
  # Color.create 50
  def initialize(gray=0.8)
    @gray=gray
  end
  
  def ps #:nodoc:
    @gray = @gray/100.0 if @gray > 1
    "#{@gray} setgray"
  end

end
