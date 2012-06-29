require File.expand_path(File.join(File.dirname(__FILE__),'spec_helper'))

describe RGhost::Border do

  it "should to use default options when user doesn't use any" do
    
    ps_string = RGhost::Border.new.ps.to_s
    options = RGhost::Border::DEFAULT_OPTIONS
    
    color = RGhost::Color.create(options[:color])
    line_width = RGhost::LineWidth.new(options[:width])
    
    ps_string.should match color.ps.to_s
    ps_string.should match line_width.ps.to_s
    ps_string.should match "#{options[:linejoin]} setlinejoin"
    ps_string.should match "#{options[:linecap]} setlinecap"
    
  end
  
  it "should set color values" do
    
    border = RGhost::Border.new :color => :red
    color = RGhost::Color.create(:red)
    border.ps.to_s.should match color.ps.to_s
    
    border = RGhost::Border.new :color => "#FF0033"
    color = RGhost::Color.create("#FF0033")
    border.ps.to_s.should match color.ps.to_s
    
  end
  
  it "should set dash values" do
    
    dash_value = {:style => [1,1,2,1,2,1,3], :offset => 1 }
    border = RGhost::Border.new :dash => dash_value
    border.ps.to_s.should match "setdash"
    
    dash = RGhost::Dash.new(dash_value)
    border.ps.to_s.should include(dash.ps.to_s)
    
    border = RGhost::Border.new :dash => false
    border.ps.to_s.should_not match "setdash"
  end

  it "should set line width values" do
    
    
    border = RGhost::Border.new :width => false
    border.ps.to_s.should_not match "setlinewidth"
    
    border = RGhost::Border.new :width => 1
    border.ps.to_s.should match "setlinewidth"
    
    line = RGhost::Line.new(1)
    border.ps.to_s.should include(line.ps.to_s)
    
  end


end