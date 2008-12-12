# Implements data method for Grid::Base. You can consult the examples at Grid::Base.
class RGhost::Grid::Matrix < RGhost::Grid::Base

  def data(_data)
    _data.each{|d| proc_line(d) }

  end

end

