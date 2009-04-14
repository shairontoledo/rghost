require 'ruby_ghost_config'
require "constants"

class RGhost::Engine
  attr_reader :errors, :error, :output
  DEFAULT_OPTIONS={:device => :pdf }
  
  include RGhost::Constants::Devices

  def initialize(document,options={})
    @document=document   
    @options=DEFAULT_OPTIONS.merge(options)
    @errors=[]
    @error=false
    @output=nil	
    @delete_input=true

  end 


  def render(device=nil)

    device||=@options[:device]
    tmp_filename=@options[:filename]
    unless tmp_filename
      tmp_filename||="#{RGhost::Config::GS[:tmpdir]}#{File::SEPARATOR}#{self.object_id.abs}"
      file_out="#{tmp_filename}.#{device}"
    else
      file_out=tmp_filename
    end

    file_err="#{tmp_filename}.rgerr"
	  
    multipage=@options[:multipage] 
    file_out.gsub!(/\./,"_%04d.") if multipage
    
    params=RGhost::Config::GS[:default_params].dup #default parameters gs engine
    params << @document.additional_params.join(" ") unless @options[:convert]
    params << "-I#{RGhost::Config::GS[:pslibdir]}"
    params << "-dPDFSETTINGS=/#{@options[:quality]}" if (@options[:device] ==:pdf && @options[:quality])
    params << "-I#{RGhost::Config::GS[:extensions].join(' -I')}" if RGhost::Config::GS[:extensions]
    params << "-sDEVICE=#{device_for(device)}"
    params.concat format_params(@options[:d],"-d") if  @options[:d]
    params.concat format_params(@options[:s],"-s") if  @options[:s]     
    params << "-r#{@options[:resolution]}" if @options[:resolution]
    params << "-g#{@options[:size]}" if @options[:size]
    if @options[:range]
      params << "-dFirstPage=#{@options[:range].first}"
      params << "-dLastPage=#{@options[:range].last}"
    end
    params << "-sstdout=#{file_err}"
    params << @options[:raw] if @options[:raw] 
    params << "-sOutputFile=#{file_out}"
     
    
    case @document 
    when RGhost::Document
        file_in="#{tmp_filename}.rgin"
      params.concat @document.gs_paper
      fi=File.open(file_in,'w')
      fi.puts @document.ps
      fi.close
    when File
        file_in=@document.path
      #@delete_input=false unless @options[:debug]
    when String
        file_in=@document
      #@delete_input=false unless @options[:debug]
    end

    params << file_in
    
    #puts params.inspect
    
    if RGhost::Config::GS[:mode] == :gslib
      require "rgengine"
      gs=RGEngine.new 
      @error=!gs.render(params,params.size)
    else
      require 'gs_alone'
      gs=RGhost::GSAlone.new(params,@options[:debug])
      @error=!gs.run
    end
    
    if @error # if error
      @errors=File.open(file_err).readlines if File.exists?(file_err)
    else
      if multipage
      	file_out.gsub!(/_%04d/,"_*")
        @output=Dir.glob(file_out).map { |f| File.open(f) }
      else
        @output=File.open(file_out)
      end
    end
    begin
      File.delete(file_err)
      File.delete(file_in) unless (@options[:debug] || @options[:convert])
    rescue
    end 
    log(params) if @options[:logfile]
    return @output
  end

  def clear_output
    case @output
    when File
        @output.close
      File.delete(@output.path)
    when Array
        @output.each do |f| 
        f.close
        File.delete(f.path)
      end
    end
  end
  def error?
    @error
  end
  private
  def log(gp)
    id=self.object_id.abs
    flog=File.open(@options[:logfile], File::WRONLY|File::APPEND|File::CREAT)
    flog.puts "[ID #{id}] created on #{Time.now}"
    flog.puts "[#{id}] RUBY GS OPTIONS: #{@options.inspect}"
    flog.puts "[#{id}] GS OPTIONS: #{gp.join(" ")}"
    if @error
      flog.puts "[#{id}] EXIT STATUS: ERROR"
      flog.puts @errors.uniq.map {|m| "[#{id}] #{m}" }.to_s;         
    else
      flog.puts "[#{id}] EXIT STATUS: OK"				
    end
  end
	
	
  def format_params(v,pre="-d")
    r=[]
    case v
    when Symbol
        r << "#{pre}#{v}"
    when Array
        v.each do |av|
        r << format_params(av,pre).to_s
      end
    when Hash
        v.each do |k,v|
        r << "#{pre}#{k}=#{v.to_s.gsub(/ /,'')}"  	
      end
    else
      return "" 
    end
    return r; 
  end

end


