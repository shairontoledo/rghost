#Defines virtual pages for the Document by method virtual_pages
class RGhost::VirtualPages < RGhost::PsObject
  
  DEFAULT_OPTIONS={:width => 5, :margin_left => 0}
  include RGhost::RubyToPs
  def initialize(&block)
    super(''){}
    @pages=[]
    instance_eval(&block) if block
  
  end

  def new_page(options=RGhost::VirtualPages::DEFAULT_OPTIONS)
    options.merge(RGhost::VirtualPages::DEFAULT_OPTIONS)
    
    @pages << options
  end
  
  def ps
    first=true
    all_pages=@pages.map do |p| 
      w=RGhost::Units::parse(p[:width]) 
      if first
        first=false
        "[#{w}]"
      else
        m=RGhost::Units::parse(p[:margin_left])
        
        "[#{w} #{m}]"
        
      end
      #"[#{m} #{w}]"
    end
    o=RGhost::PsObject.new
    o.set RGhost::Variable.new(:has_vp?, true)
    o.raw "/vp_params [ #{all_pages.join('')} ] def "
    o.call :vp_proc
    o
    
  end

end
