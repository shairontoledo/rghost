class RGhost::Grid::Style::BorderLines
  
  def set_style(grid)

    grid.before_row do |b|
      
      b.horizontal_line(:top,    :size => grid.width)
      b.horizontal_line(:bottom,    :size => grid.width)
    end

    grid.before_column :only => 0 do |b|
      b.vertical_line_row
    end
    
    grid.after_column do |c|
      c.vertical_line_row
    end
    
    
    grid.header.before_create do |c|
      c.line_width(0)
      c.use_tag :bold
      c.horizontal_line(:top, :size => grid.width)
      c.horizontal_line(:bottom,:size => grid.width)
    end
    
    grid.header.after_create {|a| a.use_tag :normal }
  

    grid.header.before_column :only => 0 do |h|
      h.vertical_line_row
    end
    
    grid.header.after_column do |h|
      h.vertical_line_row
    end
    
    
    
    
  end


end