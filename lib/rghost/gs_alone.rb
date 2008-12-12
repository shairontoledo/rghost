class RGhost::GSAlone #:nodoc:
  
  def initialize(params,debug=false)
    @params=params.dup
    @params[0]=" "
    @debug=debug
  end
  
  def run
    cmd=@params.join(" ")
    #puts File.exists?(RGhost::Config::GS[:path].to_s)
    unless File.exists?(RGhost::Config::GS[:path].to_s)
      RGhost::Config.config_platform
    end
    r=system(RGhost::Config::GS[:path]+cmd)
    
    puts RGhost::Config::GS[:path]+cmd if @debug
    #puts r
    r
  end
  

  
end

