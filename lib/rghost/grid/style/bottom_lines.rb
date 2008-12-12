

class RGhost::Grid::Style::BottomLines
  
  def set_style(grid)

    size=grid.header.size
    grid.before_row do
       horizontal_line(:bottom,:size => grid.width)

    end
    
    grid.header.before_create do
      line_width(0)
      horizontal_line(:bottom,:size => grid.width)
      use_tag :bold
    end
    
    grid.header.after_create { use_tag :normal }
      
  

    
    
    
    
  end


end