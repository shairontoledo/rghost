require "rghost/ps_object"
require "rghost/units"

#Creates one point using default unit defined in RGhost::Config::GS[:unit]
class RGhost::Point < RGhost::PsObject
  attr_accessor :x,:y
  
  def initialize(x,y)
    if x.is_a? Hash
      point=x
      @x,@y=point[:x],point[:y]
    else
      @x,@y=x,y
    end
  end

  def ps
    "#{RGhost::Units::parse(@x)} #{RGhost::Units::parse(@y)} "
  end
  

end

