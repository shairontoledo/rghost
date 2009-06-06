$LOAD_PATH << File.dirname(__FILE__)+File::SEPARATOR+"../"
require "rghost/ps_object"
require "rghost/ruby_to_ps"
require "rghost/variable"
require "rghost/units"
require "rghost/function"
require "rghost/callback"

# Grid's Header.
# You can get a header instance using:
#  grid=Grid::Rails.new
#  grid.header
#
# You can also define callbacks:
#
#  grid.header.before_column :only => [1,2] do
#   use_tag :span
#  end
#
class RGhost::Grid::Header < RGhost::PsObject
  include RGhost::RubyToPs

  DEFAULT_OPTIONS={:width => 4, :align => :center, :title_align => nil, :header_width => nil, :format => :string}
  attr_reader :data_types, :titles, :size

  def initialize(headings=true,options={},&block) #:nodoc:
    @header=RGhost::PsObject.new
    @data_types=[]
    @options=[]
    @titles=[]
    @header.set RGhost::Variable.new(:new_page?,true)  
    @default_options=DEFAULT_OPTIONS.merge(options)
    @header.set RGhost::Variable.new(:headings?,headings)
    @size=0
    instance_eval(&block) if block

  end

  def ps
    
    p,h=format_header
    @header.set RGhost::Variable.new(:header_titles,to_array(@titles))
    @header.set RGhost::Variable.new(:table_params," [\n #{p}] \n")
    @header.set RGhost::Variable.new(:table_header," [\n #{h}] \n")


    @header
  end

  def col(name="", options={}) #:nodoc:
    
    opts=@default_options.merge(options)
    @size+=opts[:width]
    @data_types << opts[:format]
    @options << opts
    @titles <<  ps_escape(name.to_s)

  end

  def default_options(opts) #:nodoc:
    @default_options.merge!(opts)

  end

  def column(name,options={}) #:nodoc:
    col(name,options)
  end

  def next_column(name,options={}) #:nodoc:
    col(name,options)
  end

  def before_create(&block)
    #@header.set RGhost::Function.new(:before_header_create, &block )
    new_static_callback(:before_header_create,&block)
  end


  def after_create(&block)
    #@header.set RGhost::Function.new(:after_header_create, &block )
    new_static_callback(:after_header_create,&block)
  end

  def before_column(options={},&block)
    @header.set RGhost::Callback.new(:before_column_header, options,&block)

  end

  def after_column(options={},&block)
    @header.set RGhost::Callback.new(:after_column_header,options,&block)

  end

  private
  def new_static_callback(name,&block)

    callback_body= RGhost::PsFacade.new(&block)
    @header.set RGhost::Function.new(name,callback_body)
  end
  def format_header
    p='' #params
    h='' #params_head
    o=@options.dup
    o.each do |v|
      v[:title_align]||=v[:align]
      v[:header_width]||=v[:width]
      p << "[ #{RGhost::Units::parse(v[:width])} /st_#{v[:align]}]\n "
      h << "[ #{RGhost::Units::parse(v[:header_width])} /st_#{v[:title_align]}]\n "
    end

    return p,h

  end


end




