require 'enumerator'
# RGhost::Grid::Base is a helper object to create a tabular
# representations, composed of rows, columns and a title.  This
# prototype used to join the common attributes for data grids. To use
# a Grid you must first setup the columns, then load the data.
#
# Example:
#  grid=Grid::Matrix.new
#  grid.column :title => "Code", :width => 1
#  grid.column :title => "Name", :width => 3, :align => :center
#  grid.column :title => "Date", :width => 3, :align => :center
#
# Note that both the width and align of the last two columns are
# identical. To avoid repetition, you can specify a default width upon
# creating the DataGrid::Grid object. Any columns that do not specify
# an explicit width and align property will inherit the defaults.
#
# Example:
#
#  grid=Grid::Matrix.new :width => 3, :align => :center
#  grid.column :title => "Code", :width => 1    #:width => 1, :align => :center
#  grid.column :title => "Name"                 #:width => 3, :align => :center
#  grid.column :title => "Date"                 #:width => 3, :align => :center
#
# The actual content needs to be passed in as an array of arrays
#
#  values=[
#    [1,"Name 1", Time.now],
#    [2,"Name 2", Time.now],
#    [3,"Name 3", Time.now],
#    [4,"Name 4", Time.now],
#    [5,"Name 5", Time.now]
#  ]
#
# Bind the content to the grid:
#  grid.data(values)
# Add the Grid to a document
#  d=Document.new
#  d.set grid
#
class RGhost::Grid::Base < RGhost::PsObject
  attr_reader :header
  attr_accessor :column_padding
  include RGhost::RubyToPs
  include RGhost::Grid::CallbackFacade

  #===Options
  #* <tt>:headings</tt> - To disable headers set this attribute to false.
  #* <tt>:column_padding</tt> - Padding between column content and its edge.
  #* <tt>:width</tt> - Width for all columns.
  #* <tt>:align</tt> - Align for all  data(:left, :center and :right).
  #* <tt>:title_align</tt> - Align for all the header's name(:left, :center and :right).
  def initialize(options={})
    
    @header=RGhost::Grid::Header.new( (options[:headings] == false)?false:true  )
    @header.default_options(options)
    @callbacks=RGhost::PsObject.new
    @column_padding= options[:column_padding] || 0.1
    @record_count=1
    @data=[]
    @data[0]=[]
    @data_index=0
    @max_stack=RGhost::Config::GS[:stack_elements]
  end


  # Defines properties of a column. Parameters are the same as for new,
  # plus some additional ones like :format.
  # * <tt>:format</tt> - Format of the data. You can format data in four
  #                      different ways with Rghost, passing in a Symbol
  #                      a String a Class or Proc.
  #
  # ==== :format Parameters type
  # * Symbol - Searches for a method defined as  Grid::FieldFormat::method_name
  #  :format => :eurodate
  # * Class - A class that inherits Grid::FieldFormat::Custom with a overridden format method.
  #  :format => MyFormat
  # * String - Formats using the same parameters used in sprintf
  #  :format => "%0.2f"
  # * Proc - A block. In the  example a text limited to 9 characters.
  #  :format => lambda {|s| s.gsub(/^(.{9}).*$/,'\1...')}
  # ====Customizing formats
  # Replace spaces with a double dash.
  #  class MyFormat < DataGrid::FieldFormat::Custom
  #   def format
  #      @value.to_s.gsub(/ /,'--')
  #   end
  #  end
  #
  # Using
  #
  #  grid.column :title => "Name", :format => MyFormat
  #
  # Below, the columns with their proper formats.
  #
  #  grid.column :title => "Code",:format => "(%d)", :width => 1
  #  grid.column :title => "Name",  :format => MyFormat
  #  grid.column :title => "Date",  :format => lambda {|date| date.strftime("%d/%m/%Y") }
  #  values=[
  #    [1,"Name 1", Time.now],
  #    [2,"Name 2", Time.now],
  #    [3,"Name 3", Time.now],
  #    [4,"Name 4", Time.now],
  #    [5,"Name 5", Time.now]
  #  ]
  #  grid.data(values)
  # Add the Grid to a document
  #
  #  d=Document.new
  #  d.set grid
  # link:images/format01.png
  def col(title="", options={})
    if title.is_a? Hash
      
      @header.col(title[:title],title)
    else
      
      @header.col(title,options)
    end
  end
  #Alias for col
  def column(title="", options={})
    col(title,options)

  end

  def format_field(value,type) #:nodoc:
    case type
    when Symbol
      RGhost::Grid::FieldFormat.send(type,value)
    when String
      RGhost::Grid::FieldFormat.string(type % value)
    when NilClass
      RGhost::Grid::FieldFormat.string(value)
    when Class
      type.new(value).gs_format
    when Proc
      RGhost::Grid::FieldFormat.string(type.call(value))

    else raise TypeError.new("type=#{type}, value type=#{value.class}")
    end

  end
  def width
    @header.size
  end
  def proc_line(line) #:nodoc:
    h=@header.data_types
    rec=[]
    line.each_with_index do |v,i|
      #puts "#{i} == #{h[i]} = #{v}, #{format_field(v,h[i])}"
      rec << format_field(v,h[i])
    end
    @data[@data_index] <<  "[#{rec.join(' ')}]\n"


    if @record_count == @max_stack
      @record_count=0
      @data_index+=1
      @data[@data_index]=[]
    end
    @record_count+=1


  end
  #Defines data to grid processor.
  def data(data)

  end
  public

  def ps


    grid_names=[]
    p=RGhost::PsObject.new
    p.set RGhost::Variable.new(:col_padding,RGhost::Units::parse(@column_padding))
    @data.each do |ary|
      r=(rand*99999).to_i
      p.raw "/data#{r}[\n#{ary.join('')}\n] def"
      grid_names << r
    end
    p.raw "#{@header.ps} #{@callbacks}"

    g=RGhost::Graphic.new do
      raw :before_table_create
      raw grid_names.map{|m| " data#{m} table_proc \n" }.join('')
      raw :after_table_create
    end
    p.set g
    p.raw :nrdp
    p


  end

  # Grid has 3 preset styles :bottom_lines, :border_lines and
  # old_forms. To set any of them, use:
  #
  #   grid.style(:border_lines)
  #
  # :border_lines - instance of Grid::Style::BorderLines
  #
  # link:images/setstyle01.png
  #
  # :bottom_lines - instance of Grid::Style::BottomLines
  #
  # link:images/setstyle02.png
  #
  # :old_forms - instance of Grid::Style::OldForms
  #
  # link:images/setstyle03.png
  def style(type=:border_lines)
    st=case type
    when :border_lines
      RGhost::Grid::Style::BorderLines.new
    when :old_forms
      RGhost::Grid::Style::OldForms.new
    when :bottom_lines
      RGhost::Grid::Style::BottomLines.new
    else raise NameError.new("Why? #{type} ?")
    end

    st.set_style(self)

  end

end
