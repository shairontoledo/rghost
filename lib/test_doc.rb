require 'rghost'

include RGhost
#d=Document.new :paper =>:A4, :row_height => 0.3, :margin_bottom => 4 , :font_encoding => 'CodePage874'
=begin
d.custom_fontmap do
  new :big,  :name => "Helvetica",:size => 12,:color => "#FF0000"
  new :code39,  :name => "Code39JK",:size => 36,:color => "#FF0000"
  new :wide,  :name => "Helvetica",:size => 200,:color => "#FFAAAA" 
  new :teste,  :name => "Helvetica",:size => 24,:color => "#FFAAAA" 
  new :foo, :size => 12 , :color => 70 #70% gray
  new :small, :name => "Helvetica-Oblique", :size => 7, :color => "#FF3300" 
  new :small2, :name => "Helvetica-Oblique", :size => 7, :color => "#AAFF33"
  new :default_font, :name => "Helvetica", :size => 8 
  new :myfont, :name => "Courier", :size => 12 
end
 =end

#Config::GS[:charset_convert]=lambda {|text| Iconv::iconv('iso8859-1', 'utf8', text) }
#Config::GS[:font_encoding] = 'IsoLatin'
#posicionamento relativo ao cursor
#d.show "Hello Grils!!2", :align=>:show_left, :font => :myfont
#d.show "Hello Grils!!2", :align=>:show_left, :font => :big, :color => "#443300" #=> override no default

#posicionamento absoluto
#d.text_in :x => 5, :y => 6, :write => "God! it's me!3", :with => :myfont
#d.text_in :x => 5, :y => 8, :write => "God! it's me!3", :with => :myfont


output_stream="/tmp/foo.pdf"
#DataGrid::RailsGrid simplificado para Grid::Rails
#puts d.ps

require 'test_data'
require 'pp'



#t.data(Domain.find(:all, :limit =>10))
#d.set t
=begin
d.load_font(:code39)
#d.font :barcode => :code39, :size => 55 
d.show "88888888552214"
d.after_page_create :only => [1,2,3] do
  text_in  :y => 1, :write => "*6274681768716176726876426*", :with => :code39
   #show "after_document_create :except [1,10]", :with => :teste
end
d.before_page_create :except => 2 do
  
  line_width 2
  show "Nome/Atualiza��o", :with => :default_font
  moveto :x => 7.5
  show "Detalhes"
  moveto :x => 18
  show "Updating"
  next_row
  horizontal_line :top
  line_width 0.3
  next_row
  text_in  :x => 9 , :y => 13, :write => "%current_page%", :with => :wide
  
 
end

Domain.find(:all, :limit =>30).each do |e|
 
  d.show "Nome #{e[:name]}"
  d.moveto :x => 7.5
  #d.next_row
  d.show "Nom�o #{e[:name]} com detalhes do cliente", :with => :small, :align => :show_left
  d.moveto :x => 10
  d.show "#{e[:created_on]} ", :with => :small, :align => :page_right
  d.next_row
  d.show "Updated on #{e[:updated_on]} ", :with => :small2
 
  d.next_row
  d.horizontal_line
  d.moveto :x => 0
  d.next_row
end
=end
output_stream="/tmp/foo.pdf"
#tf=Config.encode_test("um avião tem vários acentos")
tf=Document.new 

=begin
tf.raw %Q{
Fontmap{ 50 string cvs pop dup findfont 10 scalefont setfont

limit_left  current_row  moveto  (The quick brown fox jumps over the lazy dog)  show    
13 cm  current_row moveto default_font  0 setgray
50 string cvs show
nrdp  
} forall
}
tf.done
r=tf.render( :pdf, :filename => output_stream, :debug => true, :logfile => "/tmp/foo.log")
=end
#r=Config.enviroment_fonts.render :pdf, :filename => output_stream
#r=RGhost::Config.is_ok?.render :pdf, :filename => output_stream
d=Document.new :margin_left => 2
#d.slice_columns do |col|
d.fontmap do
  new :big,  :name => "Helvetica",:size => 8,:color => "#FF0000"
  new :default_font,  :name => "Helvetica",:size => 8
  new :pre, :name => "NimbusMonL-Regu" ,:size => 8, :encoding => false
end
d.define_template(:form, "/local/projects/ruby/rghost_rf/lib/lib/rghost/ps/rghost_default_template.eps")
#d.before_page_create :except => 2 do  
#  call :form  
#  show "ola"
#  next_row
#  horizontal_line :top
#end

#d.print_file("/tmp/text.txt")
#d.set TextArea.new(s)
#s=%q{222If proc executes the exit operator, repeat terminates prematurely. repeat leaves no results of its own on the stack, but XX ## If proc executes the exit operator, repeat terminates prematurely. repeat leaves no results of its own on the stack, but What if the printer isn't on the default queue? The destination for the printed output can be specified on the command line. To output to the file c:\out.prn, add -sOutputFile="c:/out.prn" somewhere before the name of the PostScript file. To output to a Windows 95 queue named HP DeskJet Portable Printer, use -sOutputFile="\\\\spool\HP DeskJet Portable Printer". Get the spelling exact or it won't work. For Windows 3.1 or Win32s, to output to port LPT2:}
#d.set TextArea.new(s, :width => 7)
#s= "<b>A/ctive &lta&gt Record</b> objects<big>don't a specify their</big>attributes<br/>directly, <i>but rather infer them</i> from the table definition with which they're linked. Adding, removing, and changing attributes and their type is done directly in the database. Any change is instantly reflected in the <br/>Active Record objects.<br/> The mapping that binds a given Active Record class to a certain database table will happen automatically <b>in most common cases</b>, but can be overwritten for the uncommon ones."
#d.set TextArea.new(s, :width => 8, :x => 5, :y => 15)
#d.jump_rows 9
#d.set Text.new(s)
#d.color :c => 20, :m => 60, :y => 30, :k => 0
#d.dash :style => 3
#d.line_width 0.5
 b={:color => '#FF2244',:linejoin => 1, :linecap => 2, :width => 0.5 }
 c= {:color => [100,0,0]}

#puts p.ps
#d.set p
#d.circle :x => 5, :y => 15, :border => b , :ang1 => 100,:radius => 90, :content =>  false
#d.horizontal_line(:middle, :border => {:dash => false, :color => 0.8 })
#exit



    #{:color => "#00A11A"} ,
    
    #:border => {:dash => [1,2,3], :color => "#09FF77", :width => 1}


#d.vertical_line_row(:dash => [1,2,3,4], :color => :Red)
#d.frame(:width => 10,:height => 1,  :border => { :color => :white }, :content =>{:color => :salmon})
#d.show "  teste"
#d.rectangle :content =>{:color => :red}
#d.border :color => {:c => 20, :m => 60, :y => 30, :k => 0}, :dash => 3, :width => 2
#d.shape_content :fill => true
#d.done
#d=Config.enviroment_fonts
d.use_font_tag :pre
d.print_file "/tmp/text.txt"
#d.show "Teste", :with => :pre

r=d.render :pdf, :filename => output_stream , :debug =>true 
if r.error? 
  puts r.errors
else
  `acroread #{output_stream}`
end

#AndaleMono FreeMono


=begin
/initgraphics
[(.) (/usr/share/gs-esp/8.15/lib) (/usr/share/gs-esp/8.15/Resource) (/usr/share/gs-esp/fonts) (/var/lib/defoma/gs.d/dirs/fonts) (/usr/share/cups/fonts) (/usr/share/ghostscript/fonts) (/usr/local/lib/ghostscript/fonts) (/usr/share/fonts)]
/LIBPATH


StartJobPassword
/SystemParamsPassword
/pssystemparams

(Copyright \(C\) 2004 artofcode LLC, Benicia, CA.  All rights reserved.)
/copyright
-dict-

/.runnoepsf
(ESP Ghostscript)

/.systemvmstring
/.dotorientation
[(PostScript) (PostScriptLevel1) (PostScriptLevel2) (PostScriptLevel3) (PDF)]

/.setcurvejoin
(a4)
/PAPERSIZE
6

/languagelevel
-dict-

/FIXEDMEDIA
-dict-

/.FontDirectory

--.aliasfont--
/.aliasfont


=end
