require "rghost/ps_object"
require "rghost/constants"
require "rghost/helpers"


class RGhost::Font < RGhost::PsObject #:nodoc:
  DEFAULT_OPTONS={ :size=> 8, :name => "Helvetica", :encoding => true }
  include RGhost::Constants::Fonts
  
  attr_reader :name

  def initialize(options)

    @options=DEFAULT_OPTONS.dup.merge(options)
    @options.default ""
    @options[:name]=@options[:font] if @options[:font]
    @name=@options[:name].to_s
    @name+="-encoding" if @options[:encoding]
  end

  def ps
    o=@options
    str_ret=""
#    if o[:barcode]
#      bc=RGhost::Barcode.new(o[:barcode])
#      @name=bc.font_name  
#      o[:encoding]=false   
#    end
    if o[:encoding] #define enconding 
      str_ret="/#{o[:name]} encoding_font\n"+
        "/#{o[:name]}-encoding exch definefont pop\n"
    end 
     
       
    size= o[:size]
    str_ret+=case size
    when Hash then   "/#{@name} findfont [ #{size[:width]} 0 0 #{size[:height]} 0 0] makefont setfont "
    when Array then  "/#{@name} findfont [ #{size[0]} 0 0 #{size[1]} 0 0] makefont setfont "
    when Numeric then "/#{@name} findfont #{size} scalefont setfont "
    end
    str_ret
  end

  

end


