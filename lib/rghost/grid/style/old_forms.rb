

class RGhost::Grid::Style::OldForms
  
  def set_style(grid)

    size=grid.header.size
    grid.odd_row do
      background_row(:size => size)

    end
    
    grid.header.before_create do
      line_width(0)
      background_row(:size => size, :color => RGhost::ShapeContent::DEFAULT_OPTIONS[:color] )
      use_tag :bold
    end
    
    grid.header.after_create { use_tag :normal }
      
  

    
    
    
    
  end


end