require "rghost/point"
require 'rghost/ps_object'
require 'rghost/point_with_command'
#It resposible to cursor manipulate. Use it to position objects on the page.
class RGhost::Cursor < RGhost::PsObject

  #The class method goto positioned the cursor based on page row number. Example: 
  #  d=Document.new
  #  d.goto_row 15
  #  d.show " You're on row 15"
  #  d.goto_row 3
  #  d.show "Now you're on row 3"
  #  
  #  #or without facade(**it's valid for all methods on this class**)
  #  
  #  d=Document.new
  #  d.set Cursor.goto_row(15)
  #  d.set Show.new(" You're on row 15")
  #  d.set Cursor.goto_row(3)
  #  d.set Show.new("Now you're on row 3")
  def self.goto_row(row)
    g=RGhost::PsObject.new(row.to_i)
    g.call :goto_row
    g.call :default_point
    g
  end
  #Jump n rows relative to the current row
  # d=Document.new
  # d.jump_row 4    # jump four rows below
  # d.jump_row -5   # backing five rows to up
  def self.jump_rows(row)
    j=RGhost::PsObject.new(row.to_i)
    j.call :jump_rows
    j.call :default_point
    j
  end 
  #Rotate all objects after execution it, passing the angle as argument.
  # d=Document.new
  # d.rotate 90
  # #do something
  # d.rotate -90  # backing to source angle 
  def self.rotate(angle)
    r=RGhost::PsObject.new(angle.to_i)
    r.call :rotate
    r 
  end
  #Move cursor to absolute point relative from default source point x=0 and y=0 of the page. It no interferes to the rows positions.
  # doc=Document.new
  # doc.moveto :x=> 10, :y=> 5
  # doc.show "Hello Girls!!!"
  def self.moveto(point={})
    RGhost::PointWithCommand.to(:moveto,point)
  end
  #It works the same way that moveto, the unique difference it's relative from current point.
  # doc=Document.new
  # doc.moveto :x=> 10, :y=> 5
  # doc.show "Hello Girls!!!"
  # doc.rmoveto :x => 5  # move to x=> 15 (10 plus 5) maintaining y => 5
  def self.rmoveto(point={})
    RGhost::PointWithCommand.to(:rmoveto,point)
  end
  #It changes the default pont to a new point(dislocate)
  # doc=Document.new
  # doc.translate :x=> 2, :y=> 1
  # doc.moveto :x => 0,:y => 0   # if it was default point(0,0) would be :x=> 2, :y=> 1
  # doc.translate :x=> -2, :y=> -1  # return to default source point
  def self.translate(point={:x =>0 , :y => 0})
    p={:x =>0 , :y => 0}.merge(point)
    RGhost::PointWithCommand.to(:translate,p)
  end
  
  #Jump one next row. It's same that jump_row(1). 
  # doc=Document.new
  # doc.show "Row 1"
  # doc.next_row
  # doc.show "Row 2"
  # doc.next_row
  # doc.show "Row 3"
  def self.next_row
    RGhost::PsObject.new(:nrdp)
  end
  #It go to next page resetting the cursors.
  # doc=Document.new
  # doc.show "Page 1 row 1"
  # doc.next_page 
  # doc.show "Page 2 row 1"
  # doc.next_page
  # doc.show "Page 3 row 1"
  def next_page
    RGhost::PsObject.new :next_page
  end
  #It go to next page without resetting the cursors. Often used for single page document.
  # doc=Document.new
  # doc.show "Page 1 row 1"
  # doc.showpage # page 2, but internally
  # doc.show "Page 1 row 1"
  # doc.showpage # page 3
  # doc.show "Page 1 row 1"
  def showpage
    RGhost::PsObject.new :showpage
  end
  #(Class method) It go to next page resetting the cursors.
  # doc=Document.new
  # doc.show "Page 1 row 1"
  # doc.next_page 
  # doc.show "Page 2 row 1"
  # doc.next_page 
  # doc.show "Page 3 row 1"
  def self.next_page
    RGhost::PsObject.new :next_page
  end
  #(Class method) It go to next page without resetting the cursors. Often used for single page document.
  # doc=Document.new
  # doc.show "Page 1 row 1"
  # doc.showpage # page 2, but internally
  # doc.show "Page 1 row 1"
  # doc.showpage # page 3
  # doc.show "Page 1 row 1"
  def self.showpage
    RGhost::PsObject.new :showpage
  end
  
end

