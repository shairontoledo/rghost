require 'spec_helper'

describe RGhost::Config do

  it 'should detect linux env properly' do
    RbConfig::CONFIG.should_receive(:[]).twice.with('host_os').and_return('linux')
    File.should_receive(:exists?).with('/usr/bin/gs').and_return(true)
    RGhost::Config.config_platform
    RGhost::Config::GS[:path].should == '/usr/bin/gs'
  end

  it 'should detect windows env properly' do
    RbConfig::CONFIG.should_receive(:[]).twice.with('host_os').and_return('mswin')
    File.should_receive(:exists?).with('C:\\gs\\bin\\gswin32\\gswin32c.exe').and_return(true)
    RGhost::Config.config_platform
    RGhost::Config::GS[:path].should == 'C:\\gs\\bin\\gswin32\\gswin32c.exe'
  end

  it 'should detect other env properly' do
    RbConfig::CONFIG.should_receive(:[]).twice.with('host_os').and_return('darwin')
    File.should_receive(:exists?).with('/usr/local/bin/gs').and_return(true)
    RGhost::Config.config_platform
    RGhost::Config::GS[:path].should == '/usr/local/bin/gs'
  end

  it 'should raise error if env is unknown' do
    RbConfig::CONFIG.should_receive(:[]).twice.with('host_os').and_return('android')
    expect{RGhost::Config.config_platform}.to raise_error(RuntimeError)
  end

  it 'should raise error if ghost script is not found' do
    RbConfig::CONFIG.should_receive(:[]).twice.with('host_os').and_return('linux')
    File.should_receive(:exists?).with('/usr/bin/gs').and_return(false)
    expect{RGhost::Config.config_platform}.to raise_error(RuntimeError)
  end

end