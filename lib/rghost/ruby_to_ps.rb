# encoding: utf-8
#Converts Ruby types to Postscript types
module RGhost::RubyToPs

  UTF8_ENCODINGS = {
    '¡' => 0xA1, '¢' => 0xA2, '£' => 0xA3, '€' => 0xA4, '¥' => 0xA5, 'Š' => 0xA6, '§' => 0xA7,
    'š' => 0xA8, '©' => 0xA9, 'ª' => 0xAA, '«' => 0xAB, '¬' => 0xAC, '®' => 0xAE, '¯' => 0xAF,
    '°' => 0xB0, '±' => 0xB1, '²' => 0xB2, '³' => 0xB3, 'Ž' => 0xB4, 'µ' => 0xB5, '¶' => 0xB6,
    '·' => 0xB7, 'ž' => 0xB8, '¹' => 0xB9, 'º' => 0xBA, '»' => 0xBB, 'Œ' => 0xBC, 'œ' => 0xBD,
    'Ÿ' => 0xBE, '¿' => 0xBF, 'À' => 0xC0, 'Á' => 0xC1, 'Â' => 0xC2, 'Ã' => 0xC3, 'Ä' => 0xC4,
    'Å' => 0xC5, 'Æ' => 0xC6, 'Ç' => 0xC7, 'È' => 0xC8, 'É' => 0xC9, 'Ê' => 0xCA, 'Ë' => 0xCB,
    'Ì' => 0xCC, 'Í' => 0xCD, 'Î' => 0xCE, 'Ï' => 0xCF, 'Ð' => 0xD0, 'Ñ' => 0xD1, 'Ò' => 0xD2,
    'Ó' => 0xD3, 'Ô' => 0xD4, 'Õ' => 0xD5, 'Ö' => 0xD6, '×' => 0xD7, 'Ø' => 0xD8, 'Ù' => 0xD9,
    'Ú' => 0xDA, 'Û' => 0xDB, 'Ü' => 0xDC, 'Ý' => 0xDD, 'Þ' => 0xDE, 'ß' => 0xDF, 'à' => 0xE0,
    'á' => 0xE1, 'â' => 0xE2, 'ã' => 0xE3, 'ä' => 0xE4, 'å' => 0xE5, 'æ' => 0xE6, 'ç' => 0xE7,
    'è' => 0xE8, 'é' => 0xE9, 'ê' => 0xEA, 'ë' => 0xEB, 'ì' => 0xEC, 'í' => 0xED, 'î' => 0xEE,
    'ï' => 0xEF, 'ð' => 0xF0, 'ñ' => 0xF1, 'ò' => 0xF2, 'ó' => 0xF3, 'ô' => 0xF4, 'õ' => 0xF5,
    'ö' => 0xF6, '÷' => 0xF7, 'ø' => 0xF8, 'ù' => 0xF9, 'ú' => 0xFA, 'û' => 0xFB, 'ü' => 0xFC,
    'ý' => 0xFD, 'þ' => 0xFE, 'ÿ' => 0xFF }

  
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
    value.to_s.gsub(/(\(|\)|\\)/,'\\\\\1') .gsub(/./) do |char|
      UTF8_ENCODINGS[char] ? "\\#{UTF8_ENCODINGS[char].to_s(8)}" : char
    end
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

