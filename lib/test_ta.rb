require 'rghost'

include RGhost
d=Document.new :paper => :A4, :row_height => 0.4


d.define_tags do
  new :big, :name => "Helvetica",:size => 12,:color => :blue
  new :foo, :size => 12 , :color => 70
  new :bar, :size => 12, :color => :yellow
  new :default_font, :name => "Helvetica", :size => 12 , :color => 50
  #new :font_normal, :size => 12
end
#d.set()
d.text_area("<br/><bar>TextArea1</bar>L1<br/>TextArea2 L2<br/><big>TextArea3 L3</big><br/>TextArea4 L4<br>TextArea5 L5 #{Time.now}<foo>coisa foo</foo>")

=begin
d.next :row
d.show "Line 1"
d.next :row
d.show "Line 2"
d.next :row
d.show "Line 3"
=end
#d.text_in :x => 5, :y => 5, :write => "Hello Humans %X% ", :with => :bar
#d.text_in :x => 7, :y => 20, :write => "Hello Humans2", :color =>"#FFAAAA"
d.jump_rows(10)
d.show "Olasd ad aa daj", :align => :show_left, :with => :big #, :color => "#FFAAAA"
d.next_row
d.show "Olasd ad aa daj", :align => :show_left, :with => :foo , :color => "#FFAAAA"
d.next_row
d.show "Olasd ad aa daj", :align => :show_left, :with => :bar #, :color => "#FFAAAA"
fn="/tmp/foo.pdf"

d.render :pdf, :filename => fn, :debug => true, :logfile => "/tmp/foo.log"

`evince #{fn}`
