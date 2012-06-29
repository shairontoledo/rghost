h2. Ruby Ghostscript

h3. The easy way to build documents

<center>
<img src="http://www.hashcode.eti.br/static_images/rghost-flow-small.gif" />
</center><br/>
<div style="font-size: 16px;background-color:#FFF9D8; border-bottom:3px dotted #FFE8CD;border-top:3px dotted #FFE8CD;margin:5px 40px;text-align:center;">
        The Ghost’s speed and ease of use will amaze you! :)
</div>
<br/>

Ruby Ghostscript (RGhost) is a library for document developers wanting a quick and easy way to generate pdf files. It's optimized to work with larger documents.
     
Notable features include: auto pagination, dynamic cursor, custom font tags, TTF and Type1 font support, virtual page(splitting into columns), image insertion, , text wrap, 32 barcodes, geometric shapes and vector drawing, EPS template support, PDF links, PDF password, Ruby on Rails data grid and multiple output formats.


h3. And now, it's hello world

Create a file with content
<pre><code>
 doc=RGhost::Document.new
 doc.show 'Hello World' , :color => :blue
 doc.render :pdf, :filename => "hello.pdf"
</code></pre>

"RGhost Manual(outdated)":http://rubyforge.org/docman/view.php/3796/5901/rghost_manual0.8.pdf <br/>
"RGhost RDOC(outdated)":http://rghost.rubyforge.org/rdoc/index.html </br>
"RGhost English Group(new)":http://groups.google.com/group/rghost  </br>
"RGhost Grupo em Português(novo)":http://groups.google.com/group/rghost-pt </br>
  
Both above are outdated, please see this wiki, it has been updating constantly ...

h2. Adapters

"RGhost Barcode":http://rghost-barcode.rubyforge.org/ 
"RGhost Rails":http://github.com/shairontoledo/RGhost-Rails/tree/master


h2. Wiki Pages

* "About RGhost":http://github.com/shairontoledo/rghost/wikis/about-rghost <br/>

h3. Configuring

* Installation "Linux":http://github.com/shairontoledo/rghost/wikis/linux-installation , "MacOSX":http://github.com/shairontoledo/rghost/wikis/mac-os-installation , "Windows":http://github.com/shairontoledo/rghost/wikis/windows-installation <br/>
* "Environment Test":http://github.com/shairontoledo/rghost/wikis/environment-test <br/>
* "Optional Configuration":http://github.com/shairontoledo/rghost/wikis/optional-configuration
* [[Using external fonts with Fontmap]]

h3. RGhost way

* [[Basic usage]]
* [[Units]]
* [[Page Control]]
* [[Paper and Page Layout]]
* [[Fonts]]
* [[Defining and Using Tags]]
* [[Document and Callbacks]]
* [[Color RGB CMYK and Grayscale]]
* [[Object Orientation and Position]]
* PDF
** [[PDF Security]]
** [[PDF Hyperlink (Text and Rectangle)]] 
** [[ PDF Document Info]]
** [[PDF Quality]]
** [[Converting PDF into other formats]]
* [[Zoom and Scale]]
* Graphic shapes
** [[Changing defaults colors]]
** [[Border]]
** [[Lines]]
** [[Rounded Corners, Frame, Rectangle and Square]]
** [[Circle]]
** [[Polygon]]
* [[Printing]]
* [[External Encoding (for Ruby 1.9)]]
* [[Printing text]]
* [[Printing text from file]]
* [[Virtual pages]]
* [[Working with templates and images]]
* Rails
** [[Render for Rails and Sockets(inline)]]
** [[Working with data and ActiveRecord]]
    
* Advanced     
** [[Postscript API's Internal Stack]]

*  Constants
** [[RGhost::Constants::Papers::STANDARD]]
** [[Supported Devices, Drivers and Formats]]

h3. Change Log
* Version 0.8.7 - Every callbacks need a block variable 


h2. Get also

"Ghostscript for Windows":http://pages.cs.wisc.edu/~ghost/ <br/>
"RGhost Barcode":http://rghost-barcode.rubyforge.org/

