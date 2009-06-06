require "rghost/callback" 
#Dynamic Callbacks
class RGhost::Grid::DynamicCallback < RGhost::Callback
  ACCEPT=[:before_row, :after_row, :even_row, 
            :odd_row, :before_column, :after_column, :even_column, :odd_column]
      
  def initialize(name,options={},&block)
    raise NameError.new("#{name} no accept in #{self.class}") unless ACCEPT.include? name
    super(name,options,&block)
  end
  
end
