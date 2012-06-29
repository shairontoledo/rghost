require File.expand_path(File.join(File.dirname(__FILE__),'spec_helper'))

describe RGhost::Cursor do
   
  it "should go to a row" do
   RGhost::Cursor.goto_row(10).ps.strip.should == "10 goto_row  default_point"  
   RGhost::Cursor.goto_row(20).ps.strip.should == "20 goto_row  default_point"  
    
  end
  
  it "should jump rows" do
   RGhost::Cursor.jump_rows(10).ps.strip.should == "10 jump_rows  default_point"  
   RGhost::Cursor.jump_rows(20).ps.strip.should == "20 jump_rows  default_point"    
  end
  
  it "should define a rotation angle" do
   RGhost::Cursor.rotate(45).ps.strip.should == "45 rotate"  
   RGhost::Cursor.rotate(90).ps.strip.should == "90 rotate"   
  end
  
  it "should move to a ps point" do
   RGhost::Cursor.moveto(:x => 10, :y => 20).ps.strip.should == "10 cm  20 cm  moveto"
   RGhost::Cursor.moveto(:x => 20, :y => 10).ps.strip.should == "20 cm  10 cm  moveto"
   
  end
  
  it "should move to a relative ps point" do
   RGhost::Cursor.rmoveto(:x => 10, :y => 20).ps.strip.should == "10 cm  20 cm  rmoveto"
   RGhost::Cursor.rmoveto(:x => 20, :y => 10).ps.strip.should == "20 cm  10 cm  rmoveto"
   
  end
  
  it "should displace to a ps point" do
   RGhost::Cursor.translate(:x => 10, :y => 20).ps.strip.should == "10 cm  20 cm  translate"
   RGhost::Cursor.translate(:x => 20, :y => 10).ps.strip.should == "20 cm  10 cm  translate"
   
  end
  
  it "should call internal ps function to calculate new line in the doc" do
   RGhost::Cursor.next_row.ps.should == "nrdp "
  end

  it "should go to next page" do
   RGhost::Cursor.next_page.ps.strip.should == "next_page"
  end
  
  it "should call showpage" do
   RGhost::Cursor.showpage.ps.strip.should == "showpage"
  end
  


end