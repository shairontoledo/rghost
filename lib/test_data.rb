require 'rubygems'
require 'active_record'
require 'fileutils'

require 'rghost'


ActiveRecord::Base.establish_connection(
  :adapter => 'postgresql',
  :host => 'panoramix',
  :user => 'shairon',
  :database => 'postfix'
)

class Domain < ActiveRecord::Base
  set_table_name 'domains'
  has_many :email, :class_name => "Email"
end


class Email < ActiveRecord::Base
  set_table_name 'emails'
  belongs_to :domain
end

puts Domain.find(:first).inspect 

#<Domain id: 1, name: "ih.com.br", created_on: "2008-04-09 14:40:06", updated_on: "2008-04-09 14:40:06">

include RGhost


#grid=Grid::Rails.new :width => 4, :heading => false
#grid.column :id, :title => "CÓDIGO", :align => :center
#grid.column :name, :title => "LOGIN", :align => :center, :format => lambda{|v| v.to_s+"ção"}
#grid.column :created_on, :title => "NOME", :align => :left 
#grid.style :border_lines
#domains=Domain.find(:all, :limit => 100)
#grid.data(domains)
doc = Document.new(:paper => :A4, :landscape => true, :row_per_pages => 60, :font_encoding => :IsoLatin) 
  

#rel.define_tags do
# tag :bold, :name => 'Verdana', :size => 12, :color => '#ADAD66'
#end
#rel.virtual_pages do
#  new_page :width => 10
#  new_page :width => 10, :margin_left => 1
#end

#grid.header.before_create { vertical_line_row }
#grid.header.after_create { vertical_line_row }


doc.csv_grid :style => :border_lines, :width => 2.5 do |grid|
  grid.column :title => "User", :align => :right
  grid.column :title => "Password", :format => lambda{|v| (v.to_s == "x") ? "Yes" : "No"}
  grid.column :title => "UID", :width => 1
  grid.column :title => "GID"
  grid.column :title => "Gecos", :width => 2.5
  grid.column :title => "Home Dir", :width => 4
  grid.column :title => "Shell"
  grid.data("/etc/passwd",/:/)
end
doc.next_page
doc.next_page
doc.next_row
doc.next_row
doc.next_row

doc.rails_grid :style => :border_lines, :width => 4 do |grid|
  grid.column :id, :title => "CÓDIGO", :align => :center
  grid.column :name, :title => "LOGIN", :align => :center
  grid.column :created_on, :title => "NOME", :align => :left 
  grid.data Domain.find(:all, :limit => 100, :offset => 130)
end


doc.rails_grid :style => :border_lines, :width => 4 do |grid|
  grid.column :title, :title => "Título", 
  grid.column :name, :title => "Comentário", :format => lambda {|s| s.gsub(/^(.{20}).*$/,'\1...')}
  grid.column :created_on, :title => "Data", :format => lambda {|s| s.strftime("%d %b")}
  grid.data Post.find(:all, :limit => 100)
end

doc.informations :title => "FOO BAR BAZ", :subject => "Coisas banais", :keywords => "kkkkkakka  akkakk"
doc.render :pdf, :debug => true, :filename => "/tmp/grid.pdf"


`evince /tmp/grid.pdf`


