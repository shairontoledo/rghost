require File.expand_path(File.join(File.dirname(__FILE__), "spec_helper"))

describe RGhost::Callback do
  it "should create a callback block" do
    b = RGhost::Callback.new "a_test_callback" do
    end

    expect(b.ps.strip).to eq(%(/a_test_callback 3 dict def a_test_callback begin \n/proc {     } bind def \n/except []  def \n/only []  def \nend))
  end

  it "should use 'except' when available" do
    b = RGhost::Callback.new "a_test_callback", except: [1, 2] do
    end

    expect(b.ps.strip).to eq(%(/a_test_callback 3 dict def a_test_callback begin \n/proc {     } bind def \n/except [1 2]  def \n/only []  def \nend))
  end

  it "should use 'only' when available" do
    b = RGhost::Callback.new "a_test_callback", only: [1, 2] do
    end

    expect(b.ps.strip).to eq(%(/a_test_callback 3 dict def a_test_callback begin \n/proc {     } bind def \n/except []  def \n/only [1 2]  def \nend))
  end

  it "should define ps objects inside of proc block" do
    b = RGhost::Callback.new "a_test_callback", only: [1, 2] do |cb|
      cb.showpage
    end

    expect(b.ps.strip).to eq(%(/a_test_callback 3 dict def a_test_callback begin \n/proc {   showpage    } bind def \n/except []  def \n/only [1 2]  def \nend))

    b = RGhost::Callback.new "a_test_callback", only: [1, 2] do |cb|
      cb.showpage
      cb.moveto x: 10, y: 40
    end

    expect(b.ps.strip).to eq(%(/a_test_callback 3 dict def a_test_callback begin \n/proc {   showpage  10 cm  40 cm  moveto    } bind def \n/except []  def \n/only [1 2]  def \nend))
  end
end
