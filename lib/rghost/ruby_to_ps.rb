# encoding: UTF-8

#Converts Ruby types to Postscript types
module RGhost::RubyToPs

  # http://www.w3.org/2001/06/utf-8-test/postscript-utf-8.html
  SPECIAL_CHARACTERS = {
    '¡' => 0x00A1, '¢' => 0x00A2, '£' => 0x00A3, '¤' => 0x00A4, '¥' => 0x00A5, '¦' => 0x00A6, '§' => 0x00A7, '¨' => 0x00A8,
    '©' => 0x00A9, 'ª' => 0x00AA, '«' => 0x00AB, '¬' => 0x00AC, '®' => 0x00AE, '¯' => 0x00AF, '°' => 0x00B0, '±' => 0x00B1,
    '²' => 0x00B2, '³' => 0x00B3, '´' => 0x00B4, 'µ' => 0x00B5, '¶' => 0x00B6, '·' => 0x00B7, '¸' => 0x00B8, '¹' => 0x00B9,
    'º' => 0x00BA, '»' => 0x00BB, '¼' => 0x00BC, '½' => 0x00BD, '¾' => 0x00BE, '¿' => 0x00BF, 'À' => 0x00C0, 'Á' => 0x00C1,
    'Â' => 0x00C2, 'Ã' => 0x00C3, 'Ä' => 0x00C4, 'Å' => 0x00C5, 'Æ' => 0x00C6, 'Ç' => 0x00C7, 'È' => 0x00C8, 'É' => 0x00C9,
    'Ê' => 0x00CA, 'Ë' => 0x00CB, 'Ì' => 0x00CC, 'Í' => 0x00CD, 'Î' => 0x00CE, 'Ï' => 0x00CF, 'Ð' => 0x00D0, 'Ñ' => 0x00D1,
    'Ò' => 0x00D2, 'Ó' => 0x00D3, 'Ô' => 0x00D4, 'Õ' => 0x00D5, 'Ö' => 0x00D6, '×' => 0x00D7, 'Ø' => 0x00D8, 'Ù' => 0x00D9,
    'Ú' => 0x00DA, 'Û' => 0x00DB, 'Ü' => 0x00DC, 'Ý' => 0x00DD, 'Þ' => 0x00DE, 'ß' => 0x00DF, 'à' => 0x00E0, 'á' => 0x00E1,
    'â' => 0x00E2, 'ã' => 0x00E3, 'ä' => 0x00E4, 'å' => 0x00E5, 'æ' => 0x00E6, 'ç' => 0x00E7, 'è' => 0x00E8, 'é' => 0x00E9,
    'ê' => 0x00EA, 'ë' => 0x00EB, 'ì' => 0x00EC, 'í' => 0x00ED, 'î' => 0x00EE, 'ï' => 0x00EF, 'ð' => 0x00F0, 'ñ' => 0x00F1,
    'ò' => 0x00F2, 'ó' => 0x00F3, 'ô' => 0x00F4, 'õ' => 0x00F5, 'ö' => 0x00F6, '÷' => 0x00F7, 'ø' => 0x00F8, 'ù' => 0x00F9,
    'ú' => 0x00FA, 'û' => 0x00FB, 'ü' => 0x00FC, 'ý' => 0x00FD, 'þ' => 0x00FE, 'ÿ' => 0x00FF, 'Ă' => 0x0102, 'ă' => 0x0103,
    'Ą' => 0x0104, 'ą' => 0x0105, 'Ć' => 0x0106, 'ć' => 0x0107, 'Č' => 0x010C, 'č' => 0x010D, 'Ď' => 0x010E, 'ď' => 0x010F,
    'Đ' => 0x0110, 'đ' => 0x0111, 'Ę' => 0x0118, 'ę' => 0x0119, 'Ě' => 0x011A, 'ě' => 0x011B, 'Ĺ' => 0x0139, 'ĺ' => 0x013A,
    'Ľ' => 0x013D, 'ľ' => 0x013E, 'Ł' => 0x0141, 'ł' => 0x0142, 'Ń' => 0x0143, 'ń' => 0x0144, 'Ň' => 0x0147, 'ň' => 0x0148,
    'Ő' => 0x0150, 'ő' => 0x0151, 'Œ' => 0x0152, 'œ' => 0x0153, 'Ŕ' => 0x0154, 'ŕ' => 0x0155, 'Ř' => 0x0158, 'ř' => 0x0159,
    'Ś' => 0x015A, 'ś' => 0x015B, 'Ş' => 0x015E, 'ş' => 0x015F, 'Š' => 0x0160, 'š' => 0x0161, 'Ţ' => 0x0162, 'ţ' => 0x0163,
    'Ť' => 0x0164, 'ť' => 0x0165, 'Ů' => 0x016E, 'ů' => 0x016F, 'Ű' => 0x0170, 'ű' => 0x0171, 'Ÿ' => 0x0178, 'Ź' => 0x0179,
    'ź' => 0x017A, 'Ż' => 0x017B, 'ż' => 0x017C, 'Ž' => 0x017D, 'ž' => 0x017E, 'ƒ' => 0x0192, 'ˆ' => 0x02C6, 'ˇ' => 0x02C7,
    '˘' => 0x02D8, '˙' => 0x02D9, '˛' => 0x02DB, '˜' => 0x02DC, '˝' => 0x02DD, '–' => 0x2013, '—' => 0x2014, '‘' => 0x2018,
    '’' => 0x2019, '‚' => 0x201A, '“' => 0x201C, '”' => 0x201D, '„' => 0x201E, '†' => 0x2020, '‡' => 0x2021, '•' => 0x2022,
    '…' => 0x2026, '‰' => 0x2030, '‹' => 0x2039, '›' => 0x203A, '€' => 0x20AC, '™' => 0x2122 }

  
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
      SPECIAL_CHARACTERS[char] ? "\\#{SPECIAL_CHARACTERS[char].to_s(8)}" : char
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

