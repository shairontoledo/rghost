require 'rghost'


doc=RGhost::Document.new  :paper => :A4, :margin => 0.5, :row_height => 0.4

#doc.define_template(:card, "/home/shairon/Desktop/teste.eps")
doc.define_tags do
  tag :label, :name => 'Helvetica', :size => 14
  tag :small, :name => 'Helvetica', :size => 10
  
end

doc.before_page_create :except => 1 do
  #translate :y => -1
  jump_rows(3)
end
doc.jump_rows(9)
12.times do 
  2.times do |i|
    doc.image "/home/shairon/Desktop/teste.eps", :y => :current_row
    doc.jump_rows(-6)
    doc.text_in :x => 5.5, :y => :current_row,  :text => "Shairon Toledo", :with => :label
    doc.next_row
    doc.text_in :x => 5.5, :y => :current_row, :text => "Desenvolvedor", :with => :small
    doc.jump_rows(5)
    doc.translate :x => 10 
  end
  doc.translate :x => -20 
  doc.jump_rows(11)
end


#10.times{ doc.next_page}

doc.render :pdf, :debug => true, :filename => "/home/shairon/Desktop/teste.pdf", :logfile => '/home/shairon/Desktop/teste.txt'

`evince /home/shairon/Desktop/teste.pdf`