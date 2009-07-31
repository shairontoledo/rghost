
module RGhost::ParseText #:nodoc:
  
  def text_to_ps
    
    unless @tag_parse
      case @options[:text_align]
      when :center, :right then
        @text.split(/\n/).map{|l| "#{to_string(l)} :text_proc_cr :nbw " }.to_s  
        jump_with=':nbw'
      when :left,nil then
        if self.class == RGhost::Text
          return @text.split(/\n/).map{|l| " :text #{to_string(l)} :text_proc nrdp " }.to_s 

        else
          @text.split(/\n/).map{|l| " :text_area #{to_string(l)} :text_proc_cr :nbw " }.to_s        
          jump_with='nrdp'
        end
      end
    end
    
    
    
    jump_with=':nbw' if self.class == RGhost::TextArea        
    
    
    ret=@text.split(/<br\/?>|\n/).map do |piece|
      text_ok=""
      piece.scan(/<([^>]+)>([^<]*.)<\/\1>|([^<>]+)/).each do |t|
        t.compact!
        if t && t.size == 1
          text_ok << ta_entry(t.first.to_s)
        else
          text_ok << ta_entry(t[1],t.first)
        end
      end
      text_ok
    end
    
    ret.join(" #{jump_with || 'nrdp' } ").gsub(/&lt/,'<').gsub(/&gt/,'>')
  end

  def ta_entry(e,tag="default_font")
    if self.class == RGhost::Text and  @options[:text_align] == :left
      " :text _#{tag} #{to_string(e)} :text_proc "  
    elsif self.class == RGhost::TextArea and @options[:text_align] == :left
      " :text_area _#{tag} #{to_string(e)} :text_proc "  
    else
      "  _#{tag} #{to_string(e)} :text_proc_cr "  
    end
  end

end
