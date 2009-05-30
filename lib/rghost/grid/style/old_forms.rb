class RGhost::Grid::Style::OldForms
  
  def set_style(grid)

    size=grid.header.size
    grid.odd_row do |o|
      o.background_row(:size => size)

    end
    
    grid.header.before_create do |h|
      h.line_width(0)
      h.background_row(:size => size, :color => RGhost::ShapeContent::DEFAULT_OPTIONS[:color] )
      h.use_tag :bold
    end
    
    grid.header.after_create {|h| h.use_tag :normal }
      
  

    
    
    
    
  end


end