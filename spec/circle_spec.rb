require File.expand_path(File.join(File.dirname(__FILE__), "spec_helper"))

describe RGhost::Circle do
  it "should use default options when user doesn't use any" do
    ps_string = RGhost::Circle.new.ps.to_s
    options = RGhost::Circle::DEFAULT_OPTIONS

    border = RGhost::Border.new
    shape = RGhost::ShapeContent.new
    x, y = RGhost::Units.parse(options[:x]), RGhost::Units.parse(options[:y])

    expect(ps_string).to include(border.ps.to_s)
    expect(ps_string).to include(shape.ps.to_s)
    expect(ps_string).to include("#{x} #{y}")

    expect(ps_string).to include(options.values_at(:radios, :ang1, :ang2, :use).join(" "))
  end

  it "should use options when defined" do
    circle = RGhost::Circle.new x: 5, y: 2.5, ang2: 90, radius: 50, content: {color: :green}
    shape = RGhost::ShapeContent.new color: :green

    x, y = RGhost::Units.parse(5), RGhost::Units.parse(2.5)
    expect(circle.ps.to_s).to include("#{x} #{y}")

    expect(circle.ps.to_s).to match shape.ps.to_s
  end

  it "should define ang2 right after ang1" do
    circle = RGhost::Circle.new x: 5, y: 2.5, ang2: 90, ang1: 45, radius: 50, content: {color: :green}
    expect(circle.ps.to_s).to include("45 90")
  end

  it "should define render algorithm 'arc' right after ang2" do
    circle = RGhost::Circle.new x: 5, y: 2.5, ang2: 90, use: :arc, ang1: 45, radius: 50, content: {color: :green}
    expect(circle.ps.to_s).to include("45 90 arc")
  end

  it "should define render algorithm 'arc' right after ang2" do
    circle = RGhost::Circle.new x: 5, y: 2.5, ang2: 90, use: :arcn, ang1: 45, radius: 50, content: {color: :green}
    expect(circle.ps.to_s).to include("45 90 arcn")
  end

  it "should define stroke as ps command" do
    circle = RGhost::Circle.new x: 5, y: 2.5, ang2: 90, ang1: 45, radius: 50, content: {color: :green}
    expect(circle.ps.to_s).to include("stroke")
  end

  it "should be surrounded by newpath ps block" do
    circle = RGhost::Circle.new x: 5, y: 2.5, ang2: 90, ang1: 45, radius: 50, content: {color: :green}
    expect(circle.ps.to_s).to match(/^gsave\s+newpath/)
    expect(circle.ps.to_s).to match(/grestore\s*$/)
  end
end
