require 'rghost'

include RGhost

output_stream="/tmp/foo.pdf"
#tf=Config.enviroment_fonts
tf=Document.new
tf.define_tags do
  new :test, :name => "Purisa", :size => 12
  new :dingbats, :name => "Dingbats", :size => 12
  new :pre, :name => "DejaVuSansMono", :size => 8
end
tf.use_tag :test
File.open("/etc/passwd").each do |l|
  tf.show "T ", :with => :dingbats
  tf.show l.chomp, :with => :test
  tf.next_row
end

#RGhost::Config::GS[:charset_convert]= lambda {|text| Iconv::iconv('latin1','utf8', text).to_s}  

#doc.show "coisão"
#doc=RGhost::Config.encode_test("coisão")
doc=Document.new
#doc.virtual_pages do
#  new_page :width => 4
#  # new_page :width => 7, :margin_left => 1
#  # new_page :width => 4, :margin_left => 1
#  
#end
#File.open("/tmp/mytext.txt").readlines.each{|l| doc.show l.to_s;doc.next_row}

#doc.define_template(:myform, '/tmp/form1.eps', :x=> 3, :y => -1)
#doc.odd_pages :except => [4] do
#  use_template :myform       # run the template
#end
#doc.text File.readlines("/tmp/mytext.txt")#.map{|v| v.strip}.join('<br/>')
doc=Document.new
doc.start_benchmark
doc.text File.readlines("/tmp/mytext.txt")#.map{|v| v.strip}.join('<br/>')
doc.text File.readlines("/tmp/mytext.txt")#.map{|v| v.strip}.join('<br/>')

doc.frame :corners => 70, :content => {:color => :red}
doc.end_benchmark


#tf.text '<myfont>My Text</myfont>on this row.<arial>Other text</arial><my_italic>Italic font</my_italic> ' 
#tf=Config.enviroment_fonts
r=doc.render( :pdf, :filename => output_stream, :debug => true, :logfile => "/tmp/foo.log")

#r=tf.render( :pdf, :filename => output_stream, :debug => true, :logfile => "/tmp/foo.log")
if r.error? 
  puts r.errors
else
  `evince #{output_stream}`
end

