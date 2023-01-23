require File.expand_path(File.join(File.dirname(__FILE__),'spec_helper'))
require 'fileutils'
describe RGhost::Convert do
  
  before :all do
    @a_pdf = RGhost.asser_path("doc.pdf")
    @multi_page = RGhost.asser_path("doc2.pdf")
  end
  
  it "should convert a pdf to jpeg" do
    
    resp = RGhost::Convert.new(@a_pdf).to :jpeg, :filename => RGhost.using_temp_dir("a_file.jpg")
    File.exist?(resp).should == true
    File.size(resp).should_not be(0)
    
  end
  
  it "should convert a pdf to tiff" do
    
    resp = RGhost::Convert.new(@a_pdf).to :tiff, :filename => RGhost.using_temp_dir("a_file.tif")
    
    File.exist?(resp).should == true
    File.size(resp).should_not be(0)
    
  end
  
  it "should convert a pdf to many pages using jpeg format" do
    
    pages = RGhost::Convert.new(@multi_page).to :jpeg, :filename => RGhost.using_temp_dir("a_file.jpg"), :multipage=> true
    pages.size.should == 2
    pages.each_with_index do |file,idx|
      file.should =~ /a_file_000#{idx+1}.jpg$/
      File.exist?(file).should == true
      File.size(file).should_not be(0)
    end
  end
  
  it "should convert a pdf to a jpeg page limited by `range` option" do
    
    pages = RGhost::Convert.new(@multi_page).to :jpeg, :filename => RGhost.using_temp_dir("a_file.jpg"), :multipage=> true, :range => 1..1
    
    file = pages.first
    file.should =~ /a_file_0001.jpg$/
    File.exist?(file).should == true
    File.size(file).should_not be(0)
    
  end

  it "should raise exception when initialize with not supported file" do
    expect{ RGhost::Convert.new(nil).to :jpeg }.to raise_error(/NilClass/)
  end
  
  

end