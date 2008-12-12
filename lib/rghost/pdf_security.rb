
class RGhost::PdfSecurity
  PERMISSION_VALUES={
     :base => -4,
     :print => -4,
     :modify => -8,
     :copy => -16,
     :annotate => -32,
     :interactive => -256,
     :copy_access =>  -512,
     :assemble => -1024,
     :high_quality_print => -2048,
     :all => -3904
     
   }
   attr_accessor :owner_password,:user_password,:key_length
  def initialize
    @permission_value=PERMISSION_VALUES[:all]
    @key_lenght=128
    @owner_password="unknow"
    @user_password="unknow"
  end
  def disable(*permissions)
    @permission_value=permissions.map{|p| PERMISSION_VALUES[p] }.inject(0){|n,i| i+=n}
  end
  def gs_params
    "-sOwnerPassword##{clear_space(@owner_password)} -sUserPassword##{clear_space(@user_password)} -dEncryptionR#3 -dKeyLength##{@key_lenght} -dPermissions##{@permission_value}"
  end
  private
  
  def clear_space(value)
    value.to_s.gsub(/([^\w])/,'')
  end
end


