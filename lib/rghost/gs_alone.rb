class RGhost::GSAlone # :nodoc:
  def initialize(params, debug = false)
    @params = params.dup
    @params[0] = " " # Get rid of the "gs" command from RGhost::Config::GS[:default_params]
    @debug = debug
  end

  def run
    cmd = @params.join(" ")
    unless File.exist?(RGhost::Config::GS[:path].to_s)
      RGhost::Config.config_platform
    end
    r = system(RGhost::Config::GS[:path] + cmd)
    puts RGhost::Config::GS[:path] + cmd if @debug
    r
  end
end
