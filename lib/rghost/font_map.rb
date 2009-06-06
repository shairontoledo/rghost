#NetDeseigners <www.ndesigners.com.br>
#Shairon Toledo <shairon.toledo@gmail.com>
require 'rghost/ps_object'
require 'rghost/font'
require 'rghost/function'


class RGhost::FontMap < RGhost::PsObject #:nodoc:
  include RGhost::RubyToPs
  def initialize(options={:font => "Helvetica", :size => 8},&block)
      
    #options[:name]=options[:font]
    @options=options
    @fonts={}
    instance_eval(&block) if block
  end
  
  def new(name,options={})
    #options[:name]=options[:font]
    @fonts[name]=options
    
  end
  def tag(name,options={})
    new(name,options)
  end
  
  
  def ps
    functions=[]
    fonts=""
    @fonts.each do |name,params|
      options=@options
      if params[:from]
        [params[:from]].flatten.each do |font|
          functions << format_custom_font(font)
        end
      
      end
      functions << RGhost::Function.new("_#{name}") do
        raw RGhost::Font.new(options.dup.merge(params)).ps
        raw( RGhost::Color.create(params[:color] || 0) ) 
      end
    end
    functions.join
  end
  
  private
  def format_custom_font(font_path)
    ps=RGhost::PsObject.new
    ps.raw "#{to_string(font_path)} findfont pop"
    ps
  end
end

