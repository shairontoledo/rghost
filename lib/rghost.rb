$LOAD_PATH << File.dirname(__FILE__)+File::SEPARATOR+"rghost"
require 'fileutils'


module RGhost
  class RenderException < Exception; end
end

require 'rghost/ruby_ghost_version'
require 'rghost/ps_object'
require 'rghost/variable'
require 'rghost/ps_facade'
require 'rghost/function'
require 'rghost/document'
require 'rghost/grid/grid'  
RGhost::Config::GS[:PATH]="/opt/local/bin/gs"


