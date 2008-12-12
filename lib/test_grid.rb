require 'rghost'
#require 'rubygems'
#require 'active_record'
include RGhost

#ActiveRecord::Base.establish_connection(
#:adapter => 'postgresql',
#:host => 'panoramix',
#:database => 'rob',
#:username => 'shairon'
#
#)
#class User < ActiveRecord::Base
#  
#end

#puts User.count

grid=Grid::CSV.new :width => 2.5
grid.column :title => "User", :align => :right
grid.column :title => "Password", :format => lambda{|v| (v.to_s == "x") ? "Yes" : "No"}
grid.column :title => "UID", :width => 1
grid.column :title => "GID"
grid.column :title => "Gecos", :width => 2.5
grid.column :title => "Home Dir", :width => 4
grid.column :title => "Shell"
grid.style  :bottom_lines
grid.data("/tmp/foo.txt",/:/)



d=Document.new  #:paper => [7.3,4], :margin => 0.2
d.define_tags do
  tag :font1, :name => 'Helvetica', :size => 10 , :color => :green 
  tag :font3, :name => 'TimesBold', :size => 11, :color => '#AA3903' 
end

v='01'
#d.call :default_font

d.set grid
t=:png
output_stream="/local/projects/ruby/rghost/lib/lib/rghost/doc/images/csvgrid#{v}.png"
#output_stream="/tmp/grid.#{t}"
d.render t, :filename => output_stream, :resolution => 200 #, :debug => true, :logfile => "/tmp/xxx.txt"



`evince #{output_stream}`
#`display #{output_stream}`