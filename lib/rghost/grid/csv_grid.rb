
# Grid::CSV allows you to import data from a csv file.

# ===Example
#
#  grid=Grid::CSV.new :width => 2
#  grid.column :title => "User", :align => :right
#  grid.column :title => "Password", :format => lambda{|v| (v.to_s == "x") ? "Yes" : "No"}
#  grid.column :title => "UID", :width => 1
#  grid.column :title => "GID"
#  grid.column :title => "Gecos", :width => 2.5
#  grid.column :title => "Home Dir", :width => 4
#  grid.column :title => "Shell"
#  grid.style  :bottom_lines
#  grid.data("/etc/passwd",/:/)
#
# link:images/csvgrid01.png
#
class RGhost::Grid::CSV < RGhost::Grid::Base
  # Pass in path to file and the record separator:
  #  grid.data("/mydir/myfile.csv", ';')
  # You can use a regular expression for record separator:
  #  grid.data("/mydir/myfile.csv", /[^\w]/)

  def data(filepath,col_sep=';')
    _data=filepath
    first=true
    _data=File.open(_data) if _data.is_a? String
    _data.each do |line|
      l=line.split(Regexp.new(col_sep)) if col_sep.is_a?(String)
      l=line.split(col_sep) if col_sep.is_a?(Regexp)
      if first
        v=l.size-@header.titles.size
        #v.times{@header.titles << "tt"}
        #l.each {|h| col(h)} if @header.titles.size == 0
        l.each {|h| col("")} if @header.titles.size == 0
        proc_line(l)
        first=false

        next
      else

        proc_line(l)
      end
    end

  end



end
