require "rghost/ps_object"
require "rghost/units"
require "rghost/load"
require "rghost/constants"
require "rghost/ruby_to_ps"
#Paper is the area where the Postscript elements/objects are drawn. 
#The margin is the document's non-printable area (both by the cursors and by the page's internal controllers). 
#The :area_x and :area_y are the printable section of the paper.
#It's used to configure definitions of paper. It automatically defined into Document by :paper parameter.
#
#link:images/paper01.png
#
class RGhost::Paper < RGhost::PsObject
  
  
  DEFAULT_OPTIONS={ :landscape => false, 
    :margin_top => 1, 
    :margin_right => 1, 
    :margin_bottom => 1,
    :margin_left => 1, 
    :duplex => false, 
    :tumble => false
  }
  attr_reader :paper, :landscape
  include RGhost::RubyToPs
  #===Examples
  #
  #====Create paper by name 
  # doc=Document.new :paper => :A4 
  #====Create paper by name in landscape
  # doc=Document.new :paper => :A4 , :landscape => true
  #====Create custom paper 
  # doc=Document.new :paper => [10,15] 
  #====Defining all margins
  # doc=Document.new :paper => :A5, :margin => 0.5
  #====Defining custom margins
  # doc=Document.new :paper => :A5, :margin => [0.5, 1, 0.5, 2]   #=>[top,right,bottom,left] clockwise 
  #====Defining particular margin
  # doc=Document.new :paper => :A5, :margin_top => 1, :margin_left => 0.3
  #====Defining two faces document to printer
  # doc=Document.new :paper => :A5, :duplex => true
  #===Parameters
  #* paper - The paper parameter can be either a Symbol or a Array. If paper parameter is a Symbol its value will search in RGhost::Constants::Papers .  If paper parameter is a Array(with two numeric elements) will be position [0] width and [1] height of page. Example:
  #   doc=Document.new :paper => :A3   #=> Build new A3 paper
  #   doc=Document.new :paper => [5,5] #=> Build new custom paper 5x5, using default unit defined in RGhost::Config::GS[:unit].
  #
  #====Configuration options:
  #* <tt>:landscape</tt> -  If set to true will invert width to height and height to width.
  #* <tt>:margin</tt> - Specifies margins non-printable area. It can be one Numeric for all margins or Array [top,right,bottom,left] margins.
  #* <tt>:duplex</tt> - Specifies two faces(for print)
  #* <tt>:tumble</tt> - Specifies kind of duplex
  #
  #
  def initialize(paper=:A4, options={})
    
    @options=DEFAULT_OPTIONS.merge(options)
    @landscape = @options[:landscape] || false
    @paper=paper  
  end 
  
  def ps
    d=format_duplex
    p=format_paper[:rg]
    m=format_margin

    lib=RGhost::Load.library :paper
    
    d<< p << m << lib.ps    
  end 

  
  def gs_paper #:nodoc:
    fp=format_paper
    p=fp[:gs]
    #["-dDEVICEWIDTHPOINTS=#{p[0]}", "-dDEVICEHEIGHTPOINTS=#{p[1]}"]
    if fp[:done]
      ["-dDEVICEWIDTHPOINTS=#{p[0]}", "-dDEVICEHEIGHTPOINTS=#{p[1]}"]
    else
      ["-dDEVICEWIDTHPOINTS=#{to_pt(p[0])}", "-dDEVICEHEIGHTPOINTS=#{to_pt(p[1])}"]
    end
  
  end


  private
  
  def to_pt(value)
    
    
    return case RGhost::Config::GS[:unit].new
    when RGhost::Units::Cm then (value.to_f*72/2.545).to_i
    when RGhost::Units::Inch then (value.to_f*72).to_i
    else
      value
    end
    
  end
  def format_margin
    #if @options[:margin]
    #  mt=mr=mb=ml=RGhost::Units::parse(@options[:margin])
    #else
    #  mt=RGhost::Units::parse(@options[:margin_top])
    #  mr=RGhost::Units::parse(@options[:margin_right])
    #  mb=RGhost::Units::parse(@options[:margin_bottom])
    #  ml=RGhost::Units::parse(@options[:margin_left])
    #end
     
    case @options[:margin]
    when Numeric then mt=mr=mb=ml=RGhost::Units::parse(@options[:margin])
    when Array then
        mt=RGhost::Units::parse(@options[:margin][0] || DEFAULT_OPTIONS[:margin_top] )
      mr=RGhost::Units::parse(@options[:margin][1] || DEFAULT_OPTIONS[:margin_right])
      mb=RGhost::Units::parse(@options[:margin][2] || DEFAULT_OPTIONS[:margin_bottom])
      ml=RGhost::Units::parse(@options[:margin][3] || DEFAULT_OPTIONS[:margin_left] )
    when Hash,NilClass
      mt=RGhost::Units::parse(@options[:margin_top   ] || DEFAULT_OPTIONS[:margin_top] )
      mr=RGhost::Units::parse(@options[:margin_right ] || DEFAULT_OPTIONS[:margin_right])
      mb=RGhost::Units::parse(@options[:margin_bottom] || DEFAULT_OPTIONS[:margin_bottom])
      ml=RGhost::Units::parse(@options[:margin_left  ] || DEFAULT_OPTIONS[:margin_left] )
    end
    
    "/margin 3 dict def margin begin /top #{mt} def /right #{mr} def /bottom #{mb} def /left	#{ml} def end\n"
  end
  
  def format_paper

    case @paper
    when Symbol then 
     
        p=RGhost::Constants::Papers::STANDARD[@paper.to_s.downcase.to_sym]
      p.reverse! if @landscape
      {:rg => "/pagesize #{to_array( p  ) } def\n", :gs => p, :done => true}
    when Array then
        @paper.reverse! if @landscape 
      {:rg => "/pagesize #{to_array( @paper.map{|v| to_pt(v) } ) } def\n", :gs => @paper, :done => false}
    end
    
    
  end
  
  
  def format_duplex
    "\n<< /Duplex #{@options[:duplex]} /Tumble #{@options[:tumble]} >> setpagedevice\n"
  end
  
end

#puts Paper.new(:A4, :landscape => true, :duplex => true, :margin=> [2,3,4,5])
