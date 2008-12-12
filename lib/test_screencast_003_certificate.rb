require 'rghost'

FILEOUT="/home/shairon/Desktop/teste2.pdf"

doc=RGhost::Document.new  :paper => :A4, :margin => 0 #, :landscape => true
doc.define_tags  do
  tag :big_name, :name => "Palatino-BoldItalic", :size => 26, :color => :blue
  tag :instructor, :name => "HelveticaOblique", :size => 12
  tag :another, :name => "Averen", :color => :red, :size => 30 , :from => "/home/shairon/Desktop/AVEREN__.TTF"
end
#doc.define_template :certificate, "/home/shairon/Desktop/certificate.eps"
#doc.before_page_create do
#  use_template :certificate
#end
                                              

doc.info :Title => "My Report about XXX",
         :Author => "Company XXX",
         :Subject => "RGhost new version",
         :Creator => "We system",
         :Keywords => "foo bar bas to search enginers"

#doc.jump_rows 20 
doc.jump_rows 10 
#doc.show "Shairon Toledo", :with => :another, :align => :page_center
#doc.jump_rows 6 
#doc.show "Expressões Regulares em Ruby", :with => :big_name, :align => :page_center
#doc.jump_rows 8 
#doc.text_link "Validade this document here", :x => 3, :url => "http://mysystem.hashcode.eti", :tag => :big_name, :color => :blue
doc.jump_rows(-6)
doc.rectangle_link :url=> "http://www.hashcode.eti.br", 
                   :width => 10, :height => 5, 
                   :x => 5,:y => 22, 
                   :color => :blue

#doc.security do |sec|
#  sec.owner_password ="owner"
#  sec.user_password ="user"
#  sec.key_length = 128
#  sec.disable :all
#end

#RGhost::Config::GS[:default_params] << "-sOwnerPassword#owner -sUserPassword#user -dEncryptionR#3 -dKeyLength#128 -dPermissions#-3904"
#doc.moveto :x => 22


#doc.show "Instructor Name", :with => :instructor, :align => :show_center
doc.render :pdf,  :filename => FILEOUT , :debug => true, :logfile => "/home/shairon/Desktop/teste.txt"
#RGhost::Config.environment_fonts.render :pdf, :filename => FILEOUT
fork{
  `evince #{FILEOUT}`
}