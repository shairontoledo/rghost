require 'rghost'

doc=RGhost::Document.new  :paper => :A4, :margin => 0,  :row_height => 0.53
doc.define_tags do
  tag :label, :name => 'Helvetica', :size => 12
  tag :small, :name => 'HelveticaOblique', :size => 8
end
doc.define_template :card, '/home/shairon/Desktop/teste.eps', :x => :limit_left, :y => :current_row

2.times do |i|
  5.times do |j|
    doc.jump_rows(9)
    doc.use_template :card
    doc.jump_rows(-5)
    doc.text_area "<label>Shairon Toledo #{i},#{j}</label><br/><small>Desenvolvedor não religioso</small>", :x => 5.5
    doc.jump_rows(5)
  end
  doc.translate :x => 10 
  doc.goto_row(1)
end

doc.render :pdf,  :filename => '/home/shairon/Desktop/teste.pdf'

`evince /home/shairon/Desktop/teste.pdf`