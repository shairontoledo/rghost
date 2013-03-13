# shairon.toledo@gmail.com
# 14 de Dezembro de 2007
#
Gem::Specification.new do |s|
  s.name      = "rghost"
  s.version = "0.8.9"
  s.authors = ["Shairon Toledo"]
  s.email     = "shairon.toledo@gmail.com"
  s.homepage = "http://rghost.rubyforge.org"
  s.platform = Gem::Platform::RUBY
  s.rubyforge_project="Ruby Ghostscript Engine is a document creation and conversion API, support(PDF,PS,GIF,TIF,PNG,JPG...). It uses the GhostScript framework for the format conversion, utilizes EPS templates and is optimized to work with larger documents."
  s.summary = "Ruby Ghostscript Engine is a document creation and conversion API, support(PDF,PS,GIF,TIF,PNG,JPG...). It uses the GhostScript framework for the format conversion, utilizes EPS templates and is optimized to work with larger documents."
  s.description=s.summary
  candidates = Dir.glob("{bin,docs,lib,tests}/**/*")
  s.files     = [
    "lib/rghost",
    "lib/rghost/border.rb",
    "lib/rghost/callback.rb",
    "lib/rghost/circle.rb",
    "lib/rghost/color.rb",
    "lib/rghost/constants.rb",
    "lib/rghost/convert.rb",
    "lib/rghost/cursor.rb",
    "lib/rghost/dash.rb",
    "lib/rghost/document.rb",
    "lib/rghost/document_callback_facade.rb",
    "lib/rghost/dsc_entry.rb",
    "lib/rghost/dynamic_document_callback.rb",
    "lib/rghost/eps.rb",
    "lib/rghost/font.rb",
    "lib/rghost/font_map.rb",
    "lib/rghost/frame.rb",
    "lib/rghost/function.rb",
    "lib/rghost/gif.rb",
    "lib/rghost/graphic.rb",
    "lib/rghost/grid",
    "lib/rghost/grid/base_grid.rb",
    "lib/rghost/grid/callback_facade.rb",
    "lib/rghost/grid/csv_grid.rb",
    "lib/rghost/grid/dynamic_callback.rb",
    "lib/rghost/grid/field_format.rb",
    "lib/rghost/grid/grid.rb",
    "lib/rghost/grid/header.rb",
    "lib/rghost/grid/matrix.rb",
    "lib/rghost/grid/rails_grid.rb",
    "lib/rghost/grid/static_callback.rb",
    "lib/rghost/grid/style",
    "lib/rghost/grid/style/border_lines.rb",
    "lib/rghost/grid/style/bottom_lines.rb",
    "lib/rghost/grid/style/old_forms.rb",
    "lib/rghost/grid/style/style.rb",
    "lib/rghost/gs_alone.rb",
    "lib/rghost/helpers.rb",
    "lib/rghost/horizontal_line.rb",
    "lib/rghost/how_to.rb",
    "lib/rghost/image.rb",
    "lib/rghost/jpeg.rb",
    "lib/rghost/line.rb",
    "lib/rghost/line_width.rb",
    "lib/rghost/load.rb",
    "lib/rghost/newpath.rb",
    "lib/rghost/paper.rb",
    "lib/rghost/parse_text.rb",
    "lib/rghost/pdf_security.rb",
    "lib/rghost/point.rb",
    "lib/rghost/point_with_command.rb",
    "lib/rghost/polygon.rb",
    "lib/rghost/ps",
    "lib/rghost/ps/_cusor.ps",
    "lib/rghost/ps/AdobeExpert.enc",
    "lib/rghost/ps/AdobeLatinEncoding.enc",
    "lib/rghost/ps/basic.ps",
    "lib/rghost/ps/begin_document.ps",
    "lib/rghost/ps/Bengali.enc",
    "lib/rghost/ps/callbacks.ps",
    "lib/rghost/ps/code128.font",
    "lib/rghost/ps/code39.font",
    "lib/rghost/ps/CodePage1250.enc",
    "lib/rghost/ps/CodePage1251.enc",
    "lib/rghost/ps/CodePage1252.enc",
    "lib/rghost/ps/CodePage1253.enc",
    "lib/rghost/ps/CodePage1254.enc",
    "lib/rghost/ps/CodePage1256.enc",
    "lib/rghost/ps/CodePage1257.enc",
    "lib/rghost/ps/CodePage1258.enc",
    "lib/rghost/ps/CodePage874.enc",
    "lib/rghost/ps/cursor.ps",
    "lib/rghost/ps/datagrid.ps",
    "lib/rghost/ps/developer.ps",
    "lib/rghost/ps/ean.font",
    "lib/rghost/ps/eps.ps",
    "lib/rghost/ps/font.ps",
    "lib/rghost/ps/Fontmap",
    "lib/rghost/ps/frame.ps",
    "lib/rghost/ps/gif.ps",
    "lib/rghost/ps/horizontal_line.ps",
    "lib/rghost/ps/i25.font",
    "lib/rghost/ps/IsoLatin.enc",
    "lib/rghost/ps/jpeg.ps",
    "lib/rghost/ps/link.ps",
    "lib/rghost/ps/MacCentralEuropean.enc",
    "lib/rghost/ps/MacCyrillice.desnc",
    "lib/rghost/ps/MacGreek.enc",
    "lib/rghost/ps/MacHebrew.enc",
    "lib/rghost/ps/paper.ps",
    "lib/rghost/ps/rect_link.ps",
    "lib/rghost/ps/rectangle.ps",
    "lib/rghost/ps/rghost_default_template.eps",
    "lib/rghost/ps/row.ps",
    "lib/rghost/ps/show.ps",
    "lib/rghost/ps/table_callbacks.ps",
    "lib/rghost/ps/TeX-CorkEncoding.enc",
    "lib/rghost/ps/TeX-LGR-Greek.enc",
    "lib/rghost/ps/TeX-T2AModified2Encoding.enc",
    "lib/rghost/ps/TeX-T2BAdobeEncoding.enc",
    "lib/rghost/ps/TeX-T2CAdobeEncoding.enc",
    "lib/rghost/ps/TeX-X2AdobeEncoding.enc",
    "lib/rghost/ps/TeX-XL2encoding.enc",
    "lib/rghost/ps/TeXMathExtensionEncoding.enc",
    "lib/rghost/ps/TeXMathItalicEncoding.enc",
    "lib/rghost/ps/TeXMathSymbolEncoding.enc",
    "lib/rghost/ps/text.ps",
    "lib/rghost/ps/textarea.ps",
    "lib/rghost/ps/type.ps",
    "lib/rghost/ps/unit.ps",
    "lib/rghost/ps/US-ASCII.enc",
    "lib/rghost/ps/UTF-8.enc",
    "lib/rghost/ps/vertical_line.ps",
    "lib/rghost/ps/virtual_pages.ps",
    "lib/rghost/ps_facade.rb",
    "lib/rghost/ps_object.rb",
    "lib/rghost/rectangle_link.rb",
    "lib/rghost/ruby_ghost_config.rb",
    "lib/rghost/ruby_ghost_engine.rb",
    "lib/rghost/ruby_ghost_version.rb",
    "lib/rghost/ruby_to_ps.rb",
    "lib/rghost/scale.rb",
    "lib/rghost/shape_content.rb",
    "lib/rghost/show.rb",
    "lib/rghost/static_document_callback.rb",
    "lib/rghost/text.rb",
    "lib/rghost/text_in.rb",
    "lib/rghost/text_link_in.rb",
    "lib/rghost/textarea.rb",
    "lib/rghost/units.rb",
    "lib/rghost/variable.rb",
    "lib/rghost/vertical_line.rb",
    "lib/rghost/virtual_pages.rb",
    "lib/rghost.rb"
  ]
  s.require_path      = "lib"
end

