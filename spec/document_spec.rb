# frozen_string_literal: true

RSpec.describe RGhost::Document do
  it "should to use default options when user doesn't use any" do
    doc = RGhost::Document.new
    r = doc.render :pdf, filename: RGhost.using_temp_dir("testdoc.pdf")
    expect(File.exist?(r.output)).to be true
  end

  it "should create a new document with empty body" do
    doc = RGhost::Document.new
    expect(doc.body.strip).to eq("")
  end

  it "should create a new document using A4 portrait" do
    doc = RGhost::Document.new
    expect(doc.paper.paper).to eq(:A4)
    expect(doc.paper.landscape).to eq(false)
  end

  it "should create a new document using A4 landscape" do
    doc = RGhost::Document.new landscape: true
    expect(doc.paper.paper).to eq(:A4)
    expect(doc.paper.landscape).to eq(true)
  end

  it "should create a new document using custom paper" do
    doc = RGhost::Document.new landscape: true, paper: [10, 20]
    expect(doc.paper.paper).to eq([20, 10])
  end

  it "should get gs paper definitions" do
    doc = RGhost::Document.new paper: [10, 20]
    expect(doc.gs_paper).to eq(["-dDEVICEWIDTHPOINTS=282", "-dDEVICEHEIGHTPOINTS=565"])
  end

  it "should define :rows_per_page" do
    doc = RGhost::Document.new rows_per_page: 40
    doc.variables[:row_padding] == 40
  end

  it "should define :row_height" do
    doc = RGhost::Document.new row_height: 2
    doc.variables[:row_height] == 2
  end

  it "should define :row_padding" do
    doc = RGhost::Document.new row_padding: 1.5
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
      "rect_link.ps"
    ]

    doc = RGhost::Document.new

    ps = doc.ps
    libs.each do |libname|
      expect(ps).to include(libname)
    end
  end

  it "should define tags" do
    doc = RGhost::Document.new
    doc.define_tags do
      tag :my_test_tag, name: "Helvetica"
      tag :xxx_test_tag, name: "Helvetica"
    end

    expect(doc.ps).to match "/_xxx_test_tag"
  end

  it "should define functions" do
    doc = RGhost::Document.new
    doc.define :testing_function do |f1|
      f1.set RGhost::PsObject.new("foobar")
    end

    func_def = <<~FUNC.strip
      /_testing_function{
       foobar  
      }
    FUNC

    expect(doc.ps).to include(func_def)
  end
end
