class RGhost::Grid::Style::BottomLines
  
  def set_style(grid)

    size=grid.header.size
    grid.before_row do |b|
       b.horizontal_line(:bottom,:size => grid.width)

    end
    
    grid.header.before_create do |h|
      h.line_width(0)
      h.horizontal_line(:bottom,:size => grid.width)
      h.use_tag :bold
    end
    
    grid.header.after_create {|h| h.use_tag :normal }
      
  

    
    
    
    
  end


end