require 'rghost'

include RGhost
d=Document.new :paper => :A4, :landscape => false, :margin_top => 3, :margin_bottom => 3.5, :row_height => 1
#d.show "Hello" , :align => :show_left, :font => :span

d.custom_fontmap do
  new :big, :size => 40
end

0.upto(139) do |v|
  d.set  Rectangle.background_row(:color => Gray.new("0.#{v}".to_f))
  d.show "Teste #{v}"
  d.next :row
end
d.define :myreport do
  set Image.for("/tmp/teste.eps")
end
d.define :cover do
  set Image.for("/tmp/cover.eps", :zoom => 50)
end
#d.raw "ssdfsdf"
d.before_page_create :except => 1 do
  call :myreport
end
d.first_page   do
  call :cover
  call :next_page
end
d.after_page_create do
  set TextIn.new(:x => 5, :y => 5, :write => "OLLLLLLLAAAAAAAA!!!!!!!!", :with => :big)
end
d.after_document_create do
   set TextIn.new(:x => 5, :y => 10, :write => "END OF DOCUMENT", :with => :big)
end 

d.print_file("/etc/passwd")
d.done
#puts d
`evince /tmp/test.pdf` if d.render :pdf, :filename => "/tmp/test.pdf", :logfile => "/tmp/test.log", :debug => true



