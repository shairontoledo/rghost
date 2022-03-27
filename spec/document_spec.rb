require File.expand_path(File.join(File.dirname(__FILE__),'spec_helper'))

describe RGhost::Document do

  it "should to use default options when user doesn't use any" do
    
    doc = RGhost::Document.new
    r = doc.render :pdf, :filename => RGhost.using_temp_dir("testdoc.pdf")
    File.exist?(r.output).should be true
    
  end

  it "should create a new document with empty body" do
    
    doc = RGhost::Document.new
    doc.body.strip.should == ""
    
  end
  
  it "should create a new document using A4 portrait" do
    
    doc = RGhost::Document.new
    doc.paper.paper.should == :A4
    doc.paper.landscape.should == false
    

  end

  it "should create a new document using A4 landscape" do
    
    doc = RGhost::Document.new :landscape => true
    doc.paper.paper.should == :A4
    doc.paper.landscape.should == true

  end

  it "should create a new document using custom paper" do
    
    doc = RGhost::Document.new :landscape => true, :paper => [10,20]
    doc.paper.paper.should == [20,10]

  end

  it "should get gs paper definitions" do
    
    doc = RGhost::Document.new :paper => [10,20]
    doc.gs_paper.should == ["-dDEVICEWIDTHPOINTS=282", "-dDEVICEHEIGHTPOINTS=565"]

  end

  it "should define :rows_per_page" do
    
    doc = RGhost::Document.new :rows_per_page  => 40
    doc.variables[:row_padding] == 40

  end
  
  it "should define :row_height" do
    
    doc = RGhost::Document.new :row_height  => 2
    doc.variables[:row_height] == 2

  end

  it "should define :row_padding" do
    
    doc = RGhost::Document.new :row_padding  => 1.5
    doc.variables[:row_padding] == 1.5

  end

  it "should define essential libs" do
    libs = [
      "basic.ps",
      "cursor.ps",
      "rectangle.ps",
      "font.ps",
      "textarea.ps",
      "horizontal_line.ps",
      "vertical_line.ps",
      "callbacks.ps",
      "show.ps",
      "eps.ps",
      "jpeg.ps",
      "gif.ps",
      "begin_document.ps",
      "datagrid.ps",
      "text.ps",
      "frame.ps",
      "link.ps",
      "rect_link.ps"]
    
    doc = RGhost::Document.new 
    
    ps = doc.ps
    libs.each do |libname|
      ps.should include(libname)
    end

  end
  
  it "should define tags" do
    
    doc = RGhost::Document.new 
    doc.define_tags do 
      tag :my_test_tag, :name => "Helvetica"
      tag :xxx_test_tag, :name => "Helvetica"
    end
    
    doc.ps.should match "/_xxx_test_tag"
    
  end
  
  it "should define functions" do
    doc = RGhost::Document.new 
    doc.define :testing_function do |f1|
      f1.set RGhost::PsObject.new("foobar")
      
    end
    
    doc.ps.should include("/_testing_function{
 foobar  
}")
    
  end
  

end