require "ps_object"
require "function"

class RGhost::Grid::StaticCallback < RGhost::Function
  ACCEPT=[:before_table_create, :after_table_create]

  def initialize(name,&block)
    raise NameError.new("#{name} no accept in #{self.class}") unless ACCEPT.include? name
    super(name,&block)
  end

end

