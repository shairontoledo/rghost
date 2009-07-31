#Converts Ruby types to Postscript types
module RGhost::RubyToPs

  
  def to_string(value)
    #ps escape
    value=pack_string(value)
    ps_str=ps_escape(value)
    
    "(#{ps_str}) "

  end
  
  def pack_string(s)
    if RGhost::Config::GS[:charset_convert] 
      RGhost::Config::GS[:charset_convert].call(s.to_s).to_s 
    else
      s
    end
  end
	
  
  def ps_escape(value)
    #value.to_s.gsub(/\(/,'\\(').gsub(/\)/,"\\)").gsub(/\\/,"\134")
    value.to_s.gsub(/(\(|\)|\\)/,'\\\\\1')
  end
  
  def to_bool(value)
    value ? "true":"false"
  end
  
  def to_string_array(arr)
		
    "[#{arr.map{|a| to_string(a.to_s) }}] "
  end
  
  def to_array(arr)
    return "[ ]" unless arr
    ps_arr=[]
    arr.each do |a|
      ps_arr << case a
      when TrueClass,FalseClass then to_bool(a)
      when Numeric then a
      when Proc then a.to_s
      when Array then to_array(a)
      else
        to_string(a.to_s)
      end
    end
    "[#{ps_arr.join(' ')}] "
  end
  
  def hash_to_array(hash)
    to_string_array(hash.values)
  end
  
  def array_to_stack(arr)
    "#{arr.join(' ')} "
  end
  
  def string_eval(str)
    str=pack_string(str)
    return "(#{ps_escape(str)}) show " unless str =~ /%/

    s=str.scan(/([^%][a-z]*[^%]|\d+%?)|(%[^\s%]+%)/).flatten.compact
    #puts s 
    tudo=""
    s.each do |v|
      case v
      when /^%/ then tudo << "#{v.gsub(/%/,'')} to_s show "
      else
        tudo << "(#{ps_escape(v)}) show "
      end
    end
    tudo
  end
end

