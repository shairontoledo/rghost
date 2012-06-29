require File.expand_path(File.join(File.dirname(__FILE__),'spec_helper'))

describe RGhost::Dash do

  
  it "should set dash values" do
    
    options = RGhost::Dash::DEFAULT_OPTIONS
    dash = RGhost::Dash.new
    dash.ps.strip.should == "[#{options[:style].join(' ')}] #{options[:offset]} setdash"
    
  end

  it "should set create a dash with options" do
    
    dash = RGhost::Dash.new({:style => [2,1,3,1,2,1,3], :offset => 1 })
    dash.ps.strip.should == "[2 1 3 1 2 1 3] 1 setdash"
    
  end

  it "should set create a dash with options and other offset" do
    
    dash = RGhost::Dash.new({:style => [2,1,3,1,2,1,3], :offset => 2 })
    dash.ps.strip.should == "[2 1 3 1 2 1 3] 2 setdash"
    
  end

  

end