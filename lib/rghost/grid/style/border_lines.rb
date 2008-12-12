

class RGhost::Grid::Style::BorderLines
  
  def set_style(grid)

    grid.before_row do
      
      horizontal_line(:top,    :size => grid.width)
      horizontal_line(:bottom,    :size => grid.width)
    end

    grid.before_column :only => 0 do
      vertical_line_row
    end
    
    grid.after_column do
      vertical_line_row
    end
    
    
    grid.header.before_create do
      line_width(0)
      use_tag :bold
      horizontal_line(:top, :size => grid.width)
      horizontal_line(:bottom,:size => grid.width)
    end
    
    grid.header.after_create { use_tag :normal }
  

    grid.header.before_column :only => 0 do
      vertical_line_row
    end
    
    grid.header.after_column do
      vertical_line_row
    end
    
    
    
    
  end


end