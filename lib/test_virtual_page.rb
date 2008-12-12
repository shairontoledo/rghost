

require 'rghost'

include RGhost

doc=Document.new :paper => [9.5,4], :margin_top => 0.5
doc.define_tags do
  tag :font1, :name => 'Helvetica', :size => 10, :color => '#F34811' 
  tag :font2, :name => 'Times',     :size => 11, :color => '#A4297A' 
  tag :font3, :name => 'TimesBold', :size => 12, :color => '#AA3903' 
end

#corge, grault, garply, waldo, fred, plugh, xyzzy, thud, bing
#doc.show "Foo Bar Baz", :tag => :big, :align => :page_right
#doc.lineto(:x => 4, :y => 1) 
#doc=RGhost::Config.is_ok?
#doc=RGhost::Config.encode_test("Fiancé")
my_text="<font1>foo, bar, baz</font1><font2>qux, quux</font2>, corge, grault, garply, waldo, <font3>fred, plugh,</font3> xyzzy,<br/> thud, bing"
#doc.text_area my_text
#doc.text_area my_text, :width =>3
#doc.text_area my_text, :width =>3, :text_align => :center
#doc.text_area my_text, :width =>3, :text_align => :right
#doc.text_area my_text, :width =>3, :text_align => :right, :x => 3
#doc.text_area my_text, :width =>3
doc.vertical_line :start_in => 1, :size => 2, :border => {:color => :red}
v='01'
#output_stream="/tmp/teste.pdf"
output_stream="/local/projects/ruby/rghost/lib/lib/rghost/doc/images/vertical_line#{v}.png"

#r=doc.render :png , :filename => output_stream #, :logfile => "/tmp/teste.log", :debug => true
r=doc.render :png , :filename => output_stream, :resolution => 100 #, :logfile => "/tmp/teste.log", :debug => true

if r.error? 
  puts r.errors
else
  #`evince #{output_stream}`
  `display #{output_stream}`
end














