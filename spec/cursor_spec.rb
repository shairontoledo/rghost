# frozen_string_literal: true

RSpec.describe RGhost::Cursor do
  it "should go to a row" do
    expect(RGhost::Cursor.goto_row(10).ps.strip).to eq("10 goto_row  default_point")
    expect(RGhost::Cursor.goto_row(20).ps.strip).to eq("20 goto_row  default_point")
  end

  it "should jump rows" do
    expect(RGhost::Cursor.jump_rows(10).ps.strip).to eq("10 jump_rows  default_point")
    expect(RGhost::Cursor.jump_rows(20).ps.strip).to eq("20 jump_rows  default_point")
  end

  it "should define a rotation angle" do
    expect(RGhost::Cursor.rotate(45).ps.strip).to eq("45 rotate")
    expect(RGhost::Cursor.rotate(90).ps.strip).to eq("90 rotate")
  end

  it "should move to a ps point" do
    expect(RGhost::Cursor.moveto(x: 10, y: 20).ps.strip).to eq("10 cm  20 cm  moveto")
    expect(RGhost::Cursor.moveto(x: 20, y: 10).ps.strip).to eq("20 cm  10 cm  moveto")
  end

  it "should move to a relative ps point" do
    expect(RGhost::Cursor.rmoveto(x: 10, y: 20).ps.strip).to eq("10 cm  20 cm  rmoveto")
    expect(RGhost::Cursor.rmoveto(x: 20, y: 10).ps.strip).to eq("20 cm  10 cm  rmoveto")
  end

  it "should displace to a ps point" do
    expect(RGhost::Cursor.translate(x: 10, y: 20).ps.strip).to eq("10 cm  20 cm  translate")
    expect(RGhost::Cursor.translate(x: 20, y: 10).ps.strip).to eq("20 cm  10 cm  translate")
  end

  it "should call internal ps function to calculate new line in the doc" do
    expect(RGhost::Cursor.next_row.ps).to eq("nrdp ")
  end

  it "should go to next page" do
    expect(RGhost::Cursor.next_page.ps.strip).to eq("next_page")
  end

  it "should call showpage" do
    expect(RGhost::Cursor.showpage.ps.strip).to eq("showpage")
  end
end
