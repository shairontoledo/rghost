# frozen_string_literal: true

RSpec.describe RGhost::Color do
  context "color factory" do
    # String HTML color converter
    # Color.create '#FFAA33'
    # As Symbol will be find in RGhost::Constants::Colors::RGB
    # Color.create :red
    # As Array with 3 elements
    # Color.create [0.5, 0.3, 0.5]
    # Hash with 3 pair of key/value. Valids keys :red, :green and :blue
    # Color.create :red => 0.5, :green => 0.3, :blue => 0.5
    # Hash with 3 pair of key/value. Valids keys :r, :g and :b
    # Color.create :r => 0.5, :g => 0.3, :b => 0.5
    #====Creating CMYK color
    # Hash with 4 pair of key/value. Valids keys :cyan, :magenta, :yellow and :black
    #  Color.create :cyan=> 1 ,:magenta => 0.3, :yellow => 0, :black => 0
    # Hash with 4 pair of key/value. Valids keys :c, :m, :y and :b
    #  Color.create :c=> 1 ,:m => 0.3, :y => 0, :b => 0
    #====Creating CMYK Spot color
    # Hash with 5 pair of key/value. Valids keys :cyan, :magenta, :yellow, :black, and :name
    #  Color.create :cyan=> 0, :magenta => 100, :yellow => 63, :black => 12, :name => 'Pantone 200 C'
    #====Creating Gray color
    # A single Numeric
    # Color.create 0.5
    # 50 percent of black will be divided by 100.0
    # Color.create 50

    it "should create RGB color for hex color(html style)" do
      c = RGhost::Color.create "#FF00FF"
      c.instance_of?(RGhost::RGB)
      expect(c.ps.to_s).to eq("1.0 0.0 1.0 setrgbcolor")
    end

    it "should create RGB color by color name" do
      c = RGhost::Color.create :red
      c.instance_of?(RGhost::RGB)
      expect(c.ps.to_s).to eq("1.0 0.0 0.0 setrgbcolor")
    end

    it "should create RGB color by array, 3 elements" do
      c = RGhost::Color.create [1, 0, 1]
      c.instance_of?(RGhost::RGB)
      expect(c.ps.to_s).to eq("1 0 1 setrgbcolor")
    end

    it "should create color with hash and RGB color names" do
      c = RGhost::Color.create red: 0.5, green: 0.7, blue: 1
      c.instance_of?(RGhost::RGB)
      expect(c.ps.to_s).to eq("0.5 0.7 1 setrgbcolor")
    end

    it "should create color with hash and RGB short color names " do
      c = RGhost::RGB.new r: 0.5, g: 0.7, b: 1
      c.instance_of?(RGhost::RGB)
      expect(c.ps.to_s).to eq("0.5 0.7 1 setrgbcolor")
    end

    it "should create a color by hash" do
      c = RGhost::Color.create cyan: 1, magenta: 0.3, yellow: 0, black: 1
      c.instance_of?(RGhost::CMYK)
      expect(c.ps.to_s).to eq("1 0.3 0 1 setcmykcolor")
    end

    it "should create a color by hash with short names" do
      c = RGhost::Color.create c: 1, m: 0.3, y: 0, k: 1
      c.instance_of?(RGhost::CMYK)
      expect(c.ps.to_s).to eq("1 0.3 0 1 setcmykcolor")
    end

    it "should create a color by hash with short names" do
      c = RGhost::Color.create [1, 0.3, 0, 1]
      c.instance_of?(RGhost::CMYK)
      expect(c.ps.to_s).to eq("1 0.3 0 1 setcmykcolor")
    end

    it "should create a color by a numeric" do
      c = RGhost::Color.create 0.5
      c.instance_of?(RGhost::Gray)
      expect(c.ps.to_s).to eq("0.5 setgray")
    end
  end

  context RGhost::Gray do
    it "should create gray scale" do
      c = RGhost::Gray.new 1
      expect(c.ps.to_s).to eq("1 setgray")

      c = RGhost::Gray.new 0.5
      expect(c.ps.to_s).to eq("0.5 setgray")
    end

    it "should create gray scale using percentage" do
      c = RGhost::Gray.new 100
      expect(c.ps.to_s).to eq("1.0 setgray")

      c = RGhost::Gray.new 50
      expect(c.ps.to_s).to eq("0.5 setgray")
    end
  end

  context RGhost::CMYK do
    it "should create a color using default values" do
      c = RGhost::CMYK.new
      expect(c.ps.to_s).to eq("1 0 0 0 setcmykcolor")
    end

    it "should create a color by hash" do
      c = RGhost::CMYK.new cyan: 1, magenta: 0.3, yellow: 0, black: 1
      expect(c.ps.to_s).to eq("1 0.3 0 1 setcmykcolor")
    end

    it "should create a color by hash with short names" do
      c = RGhost::CMYK.new c: 1, m: 0.3, y: 0, k: 1
      expect(c.ps.to_s).to eq("1 0.3 0 1 setcmykcolor")
    end

    it "should create a color by array with 4 elements" do
      c = RGhost::CMYK.new [1, 0.3, 0, 1]
      expect(c.ps.to_s).to eq("1 0.3 0 1 setcmykcolor")
    end
  end

  context RGhost::RGB do
    it "should create a color from a hex(html style)" do
      c = RGhost::RGB.new "#ABBACA"
      expect(c.ps.to_s).to eq("0.6705882352941176 0.7294117647058823 0.792156862745098 setrgbcolor")

      c = RGhost::RGB.new "#FFFFFF"
      expect(c.ps.to_s).to eq("1.0 1.0 1.0 setrgbcolor")

      c = RGhost::RGB.new "#000000"
      expect(c.ps.to_s).to eq("0.0 0.0 0.0 setrgbcolor")

      c = RGhost::RGB.new "#FF0000"
      expect(c.ps.to_s).to eq("1.0 0.0 0.0 setrgbcolor")

      c = RGhost::RGB.new "#FFFF00"
      expect(c.ps.to_s).to eq("1.0 1.0 0.0 setrgbcolor")

      c = RGhost::RGB.new "#334455"
      expect(c.ps.to_s).to eq("0.2 0.26666666666666666 0.3333333333333333 setrgbcolor")
    end

    # it "should create a color from a name defined at RGhost::Constants::Colors::RGB" do
    it "should create a color from a array with 3 elements" do
      c = RGhost::RGB.new [0, 0, 0]
      expect(c.ps.to_s).to eq("0 0 0 setrgbcolor")

      c = RGhost::RGB.new [1, 1, 1]
      expect(c.ps.to_s).to eq("1 1 1 setrgbcolor")

      c = RGhost::RGB.new [0.5, 0.5, 0.5]
      expect(c.ps.to_s).to eq("0.5 0.5 0.5 setrgbcolor")
    end

    it "should truncate values greater than 1" do
      c = RGhost::RGB.new [2, 2, 2]
      expect(c.ps.to_s).to eq("0.02 0.02 0.02 setrgbcolor")
    end

    it "should create color with hash and RGB color names" do
      c = RGhost::RGB.new red: 0.5, green: 0.7, blue: 1
      expect(c.ps.to_s).to eq("0.5 0.7 1 setrgbcolor")
    end

    it "should create color with hash and RGB short color names " do
      c = RGhost::RGB.new r: 0.5, g: 0.7, b: 1
      expect(c.ps.to_s).to eq("0.5 0.7 1 setrgbcolor")
    end
  end
end
