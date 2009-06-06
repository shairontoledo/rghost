
module RGhost::Grid
  # The callbacks for the grid are defined here. Let's see them in action.
  # ===Grid::CallbackFacade examples
  #  grid=Grid::Matrix.new :column_padding => 1
  #  grid.column :title => "Id", :width => 1
  #  grid.column :title => "Name", :width => 3, :align => :center
  #  grid.column :title => "Date", :width => 3, :align => :right, :title_align => :center,  :format => lambda{|v| v.strftime("%d/%m/%Y")}
  #  values=('A'..'E').to_a.map{|v|  [v,"Name #{v}", Time.now]}
  #
  # even_row:
  #  grid.even_row do |e|
  #   e.background_row(:size => grid.width)
  #  end
  # link:images/grid01.png
  #
  # Now before_row to create a top and bottom line:
  #  grid.before_row do |b|
  #   b.horizontal_line(:top,    :size => grid.width )
  #   b.horizontal_line(:bottom, :size => grid.width)
  #  end
  #
  # link:images/grid02.png
  #
  # before_column:
  #  grid.before_column do |v|
  #   v.vertical_line_row
  #  end
  #
  # link:images/grid03.png
  #
  # after_column:
  #  grid.after_column {|c|  c.vertical_line_row  }
  #
  #
  # link:images/grid04.png
  #
  # Moving to the header
  #  grid.header.before_create do |b|
  #   b.horizontal_line(:top, :size => grid.width)
  #  end
  #
  # link:images/grid05.png
  #
  # Finishing the grid lines:
  #  grid.header.before_column do |b|
  #    b.vertical_line_row
  #  end
  #
  #
  #  grid.header.after_column do |b|
  #   b.vertical_line_row
  #  end
  #
  # link:images/grid06.png
  #
  # Now a adding a bold font to the header
  #  grid.header.before_create do |b|
  #    b.horizontal_line(:top, :size => grid.width)
  #    b.use_tag :bold
  #   end
  #
  # link:images/grid07.png
  #
  # Oops. Not quite what we expected, the entire grid used bold
  # face. We need to use a header callback to reset the font.
  #
  #  grid.header.after_create do
  #     b.use_tag :normal
  #   end
  #
  # link:images/grid08.png
  #
  # Don't forget
  #
  #  doc=Document.new
  #  doc.set grid
  module CallbackFacade

    # Executes before processing row. Responds to :only and :except
    # options.
    def before_row(options={},&block)
      new_dynamic_callback(:before_row,options,&block)
    end

    # Executes on creating an odd rows. Responds to :only and :except
    # options.
    def odd_row(options={},&block)
      new_dynamic_callback(:odd_row,options,&block)
    end

    # Executes upon creating even rows. Responds to :only and :except
    # options.
    def even_row(options={},&block)
      new_dynamic_callback(:even_row,options,&block)
    end

    # Executes before creating a column. Responds to :only and :except
    # options.
    def before_column(options={},&block)
      new_dynamic_callback(:before_column,options,&block)
    end

    # Executes after a column was created. Responds to :only and
    # :except options.
    def after_column(options={},&block)
      new_dynamic_callback(:after_column,options,&block)
    end

    # Executes when creating an odd column. Responds to :only and
    # :except options.
    def odd_column(options={},&block)
      new_dynamic_callback(:odd_column,options,&block)
    end

    # Executes upon creating an even column. Responds to :only and
    # :except options.
    def even_column(options={},&block)
      new_dynamic_callback(:even_column,options,&block)
    end


    private

    def new_dynamic_callback(name,options={},&block)
      @callbacks.set RGhost::Callback.new(name,options,&block)
    end
    def new_static_callback(name,&block)

      callback_body= RGhost::PsFacade.new(&block)
      @callbacks.set RGhost::Function.new(name,callback_body)
    end


  end
end
