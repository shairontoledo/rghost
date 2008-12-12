# Convert PDF file to another format using commom render parameters of the Engine
# A additional parameter for this method is :range. Below someone examples:
# 
# ====Only cover page
#  Convert.new("/dir/myfile.pdf").to :jpeg, :filename => "/tmp/test.jpg"
# 
# ====One page per file
# It's generate file with pattern test_0001.png, test_0002.png, etc
#  Convert.new("/dir/myfile.pdf").to :png, :multipage => true, :filename => "/tmp/test.png"
# 
# ====One page per file with page range
#  Convert.new("/dir/myfile.pdf").to :eps,  :multipage => true, :filename => "/tmp/test.eps", :range => 1..5
# 
# ====Getting files after convertion
#  files=Convert.new("/dir/myfile.pdf").to :eps,  :multipage => true, :filename => "/tmp/test.eps", :range => 1..5
#  files.class # => Array because parameter multipage is true
#  
#  file=Convert.new("/dir/myfile.pdf").to :eps, :filename => "/tmp/test.eps"
#  file.class # => File 
# 
class RGhost::Convert 
  attr_reader :error, :errors
  
  
  def initialize(filename)
    @filename=filename
    
    
  end

  
  def to(device, options={})
    rge=RGhost::Engine.new(@filename,{:convert=>true}.merge(options))
    
    
    out=rge.render(device)
    @error=rge.error
    @errors=rge.errors
    out
  end
  
  
end