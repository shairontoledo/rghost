require File.expand_path(File.join(File.dirname(__FILE__), "spec_helper"))
require "fileutils"
describe RGhost::Convert do
  before :all do
    @a_pdf = RGhost.asser_path("doc.pdf")
    @multi_page = RGhost.asser_path("doc2.pdf")
  end

  it "should convert a pdf to jpeg" do
    resp = RGhost::Convert.new(@a_pdf).to :jpeg, filename: RGhost.using_temp_dir("a_file.jpg")
    expect(File.exist?(resp)).to eq(true)
    expect(File.size(resp)).not_to be(0)
  end

  it "should convert a pdf to tiff" do
    resp = RGhost::Convert.new(@a_pdf).to :tiff, filename: RGhost.using_temp_dir("a_file.tif")

    expect(File.exist?(resp)).to eq(true)
    expect(File.size(resp)).not_to be(0)
  end

  it "should convert a pdf to many pages using jpeg format" do
    pages = RGhost::Convert.new(@multi_page).to :jpeg, filename: RGhost.using_temp_dir("a_file.jpg"), multipage: true
    expect(pages.size).to eq(2)
    pages.each_with_index do |file, idx|
      expect(file).to match(/a_file_000#{idx + 1}.jpg$/)
      expect(File.exist?(file)).to eq(true)
      expect(File.size(file)).not_to be(0)
    end
  end

  it "should convert a pdf to a jpeg page limited by `range` option" do
    pages = RGhost::Convert.new(@multi_page).to :jpeg, filename: RGhost.using_temp_dir("a_file.jpg"), multipage: true, range: 1..1

    file = pages.first
    expect(file).to match(/a_file_0001.jpg$/)
    expect(File.exist?(file)).to eq(true)
    expect(File.size(file)).not_to be(0)
  end

  it "should raise exception when initialize with not supported file" do
    expect { RGhost::Convert.new(nil).to :jpeg }.to raise_error(/NilClass/)
  end
end
