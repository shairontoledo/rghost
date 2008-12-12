require 'rghost'

doc=RGhost::Document.new  :paper => :A4, :margin => 0,  :row_height => 0.53

dir="/home/shairon/Desktop/screencast_002_the_photos"
doc.define_template :frame1, "/home/shairon/Desktop/coisa01.jpg", :x => 3, :y => 15
doc.define_template :frame2, "/home/shairon/Desktop/coisa01.jpg", :x => 3, :y => 3

doc.define_template :frame_small_1, "/home/shairon/Desktop/coisa01.jpg", :zoom => 23, :x => 3, :y => 23
doc.use_template :frame_small_1
doc.image "#{dir}/small/image_001_small.jpg", :x => 3.3, :y => 23.3 
doc.next_page

doc.before_page_create :except => 1 do 
  use_template :frame1
  use_template :frame2
end
Dir.glob("#{dir}/*.jpg").sort.each_with_index do |file,i|
  
  if file !~ /_small/   
  
    if ( (i % 2) == 1)
      
      doc.image file, :x => 4, :y => 4.5 
      doc.text_in :x => 4, :y => 4, :write => file
      doc.next_page  
    else
      
      doc.image file, :x => 4, :y => 16.5 
      doc.text_in :x => 4, :y => 16, :write => file
    end
  end
end

doc.render :pdf,  :filename => '/home/shairon/Desktop/teste.pdf', :debug => true, :logfile => "/home/shairon/Desktop/teste.txt"

#324x245

`evince /home/shairon/Desktop/teste.pdf`