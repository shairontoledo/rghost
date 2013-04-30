require "rghost/ps_object"
require 'rghost/font_map'

#Rghost setup with Ghostscript.
#Ghostscript runs on a variety of platforms, this is why we recommend the non coupled install for non *nix environments.
#The gem already comes with a set of defaults but you can change the settings using the Hash RGhost::Config::GS before each use of the API. Listed below are the keys of the said hash.
#===RGhost::Config::GS[:mode]
#Operating mode
#* <tt>:gsparams</tt> In this mode RGhost just pass parameters to the Ghostscript framework.
#* <tt>:gsapi</tt> based on the exchange of data between Ruby and Ghostscript via rgengine.so using gslib.so.8 or gslib-esp.so.8.
#
#===RGhost::Config::GS[:path]
#Path to the ghostscript executable.
#====Example on windows
#RGhost::Config::GS[:path] = "C:\\gs\\bin\\gswin32c.exe"
#====Example on Linux
#RGhost::Config::GS[:path] = "/usr/bin/gs"
#
#===RGhost::Config::GS[:tmpdir]
#Temporary directory
#====Example
#RGhost::Config::GS[:tmpdir] = "/tmp"
#
#===RGhost::Config::GS[:default_params]
#Allows you to add/remove options. (use with caution!)
#====Example
#RGhost::Config::GS[:default_params] << "-dSAFER"
#
#===RGhost::Config::GS[:stack_elements]
#Defines the maximum number of elements for each matrix inside postscript's internal stack, avoiding a stack overflow error..
#====Example
#RGhost::Config::GS[:stack_elements]=5000
#
#===RGhost::Config::GS[:unit]
#Set the measure units. See Units::Unit for available units.
#====Example
#RGhost::Config::GS[:unit]=Units::Cm
#
#===RGhost::Config::GS[:charset_convert]
#Ruby to PS character conversion proxy.  Necessary when the source code isn't on the same encoding of the document.
#Params is a block that returns a String. The default setting is nil.
#====Example
#RGhost::Config::GS[:charset_convert]= lambda {|text| Iconv::iconv("latin1","utf8", text).to_s}
#
#===RGhost::Config::GS[:font_encoding]
#Sets the Postscript font encoding. Default: :IsoLatin
#====Example
#RGhost::Config::GS[:font_encoding]= :IsoLatin
#
#===RGhost::Config::GS[:external_encoding]
#Sets the file-in external encoding (Ruby 1.9). Affects how data will be written and
#could help when dealing with encoding conversion errors. Default: nil
#====Example
#RGhost::Config::GS[:external_encoding]= 'ascii-8bit'
#
module RGhost::Config

  DEFAULT_PORTRAIT_TEMPLATE  = File.join(File.dirname(__FILE__),"ps","rghost_default_template.eps")


  GS={
    :mode => :gsparams,
    :raise_on_error => true,
    :plugin => nil,
    :path => nil,
    :tmpdir => ENV["TMP"] || ENV["TMPDIR"] || ENV["TEMPDIR"] || ENV["TEMP"] || "/tmp",
    :pslibdir => File.join( File.dirname(__FILE__),"ps"),
    :extensions => [],
    :preload => [],
    :default_params=> %w(gs -dNOPAUSE -dBATCH -dQUIET -dNOPAGEPROMPT),
    :stack_elements => 5000,
    :font_encoding => :IsoLatin,
    :charset_convert => begin
      if RUBY_VERSION =~ /^1.8/
        require 'iconv'
        lambda { |text| Iconv::iconv('latin1','utf-8', text).join }
      else
        lambda { |text| text.encode('ISO-8859-1', 'UTF-8') }
      end
    end,
    :external_encoding => nil,
    :fontsize => 8,
    :unit => RGhost::Units::Cm
  }

  def self.config_platform #:nodoc:
    const = 'PLATFORM'
    const = "RUBY_"+const if RUBY_VERSION =~ /1\.[89]|2\.\d/
    GS[:path]=case Object.const_get(const)
    when /linux/ then "/usr/bin/gs"
    when /darwin|freebsd|bsd/ then "/usr/local/bin/gs"
    when /mswin/ then "C:\\gs\\bin\\gswin32\\gswin32c.exe"
    end
    not_found_msg="\nGhostscript not found in your environment.\nInstall it and set the variable RGhost::Config::GS[:path] with the executable.\nExample: RGhost::Config::GS[:path]='/path/to/my/gs' #unix-style\n RGhost::Config::GS[:path]=\"C:\\\\gs\\\\bin\\\\gswin32c.exe\"  #windows-style\n"
    raise not_found_msg unless (File.exists? GS[:path])
  end

  #Test if your environment is ready to works. If yes the page below will show.
  #
  #link:images/is_ok.png
  #
  #You can generate this page with the code.
  # RGhost::Config.is_ok?.render :pdf, :filename => "/tmp/mytest.pdf"
  #
  def self.is_ok?
    d=RGhost::Document.new  :margin_left => 2.3, :margin_bottom => 2.3
    d.benchmark(:start)
    d.before_page_create do |b|
      b.image RGhost::Config::DEFAULT_PORTRAIT_TEMPLATE
    end
    d.define_tags do
      new :bigger,   :size => 150, :color => "#AAFF33"
    end
    d.text_in :x => 6, :y=> 15, :write => "Yes!", :with => :bigger
    d.text_in :x => 10, :y=> 14, :write => "Your environment is ready!"
    d.text_in :x => 10, :y=> 13, :write => "RGhost Version " + RGhost::VERSION::STRING
    d.text_in :x => 10, :y=> 12, :write => "Created at " + Time.at(RGhost::VERSION::DATE).to_s
    d.text_in :x => 10, :y=> 11, :write => "Now " + Time.now.to_s

    d.benchmark(:stop)
    d.done
    d



  end
  #This method is a helper to gets the best encoding.
  #
  #link:images/encode_test.png
  #
  #You can generate this page with the code.
  # RGhost::Config.encode_teste("Fiancé").render :pdf, :filename => "/tmp/mytest.pdf"
  #
  #The encode will use on Document class.
  # doc=Document.new :font_encoding => 'IsoLatin'
  #
  def self.encode_test(value)
    d=RGhost::Document.new  :paper => :A4, :margin_left => 2 #, :landscape => true
    d.before_page_create do |b|
      b.image RGhost::Config::DEFAULT_PORTRAIT_TEMPLATE
    end
    exp=File.join(File.dirname(__FILE__),"ps","*.enc")
    d.show "String (Using Helvetica Font)", :with => :b
    d.moveto :x => 16
    d.show "Encode Name", :with => :b
    d.horizontal_line :bottom
    d.next_row

    Dir.glob(exp).sort.each do |f|
      name=File.basename(f)
      name.gsub!(/\.enc/,'')
      d.set RGhost::Load.library(name,:enc)
      d.set RGhost::Variable.new(:default_encoding,name)
      d.set RGhost::FontMap.new {
        new(:font_test,  :name => "Helvetica",:size => 8,:color => "#FF0000", :encoding => true)
      }

      d.show "#{value}" , :with => :font_test
      d.moveto :x => 16
      d.show "#{name}", :with =>  :i
      d.next_row

    end
    d
  end
  #Generates font catalog to use into method define_tags on Document
  #  RGhost::Config.enviroment_fonts.render :pdf, :filename => "mycatalog.pdf"
  #link:images/environment_fonts.png
  #
  def self.environment_fonts(text="The quick brown fox jumps over the lazy dog")

    d=RGhost::Document.new  :margin_left => 2.3, :margin_bottom => 2.3
    d.before_page_create do |b|
      b.image RGhost::Config::DEFAULT_PORTRAIT_TEMPLATE
    end
    d.show "Search Path"
    d.horizontal_line :bottom
    d.next_row
    d.raw :default_font
    d.raw %Q{
    LIBPATH{
      limit_left  current_row  moveto   show
      nrdp
    } forall

    }
    d.next_row
    d.show "Example"
    d.moveto :x=> 13
    d.show "Font Name"
    d.horizontal_line :bottom
    d.next_row
    #=begin
    d.raw %Q{
      Fontmap{
        50 string cvs pop dup findfont 10 scalefont setfont
        limit_left  current_row  moveto  (#{text})  show
    13 cm  current_row moveto default_font  0 setgray
    50 string cvs show
    nrdp
      } forall
    }
    #=end
    d.done
    d
  end

  # .
  #
  #
  #Preseted tags
  #
  #
  #
  #FONTMAP=RGhost::FontMap.new :name => "Helvetica", :size => 8, :encoding => false do
  #    new :span
  #    new :b,     :name => "Helvetica-Bold"
  #    new :bold,     :name => "Helvetica-Bold"
  #    new :normal,   :name => "Helvetica"
  #    new :i,     :name => "Helvetica-Oblique", :size => 8
  #    new :bi,    :name => "Helvetica-BoldOblique"
  #    new :big,   :size => 10
  #    new :small, :size => 7
  #    new :h1,    :name => "Helvetica", :size => 14
  #    new :h2,    :name => "Helvetica", :size => 13
  #    new :h3,    :name => "Helvetica", :size => 12
  #    new :h4,    :name => "Helvetica", :size => 11
  #    new :h5,    :name => "Helvetica", :size => 10
  #    new :title, :name => "Helvetica", :size => 20
  #    new :pre,   :name => "Courier"
  #  end
  #
  FONTMAP=RGhost::FontMap.new :name => "Helvetica", :size => 8, :encoding => true do
    new :span
    new :b,     :name => "Helvetica-Bold"
    new :bold,     :name => "Helvetica-Bold"
    new :normal,   :name => "Helvetica"
    new :i,     :name => "Helvetica-Oblique", :size => 8
    new :bi,    :name => "Helvetica-BoldOblique"
    new :big,   :size => 10
    new :small, :size => 7
    new :h1,    :name => "Helvetica", :size => 14
    new :h2,    :name => "Helvetica", :size => 13
    new :h3,    :name => "Helvetica", :size => 12
    new :h4,    :name => "Helvetica", :size => 11
    new :h5,    :name => "Helvetica", :size => 10
    new :title, :name => "Helvetica", :size => 20
    new :pre,   :name => "Courier"
  end

end

