require "./lib/rghost"

# describe  RGhost::Grid::Base do
# it "should generate for ruby 1.9" do
vals = [
  ["col1", "col2"], ["anothercol", "anothercol2"]
]

doc = RGhost::Document.new
doc.matrix_grid(align: :center, width: 8) do |grid|
  grid.style :bottom_lines
  grid.column title: "First column", width: 3.5
  grid.column title: "Second Column", width: 3.5
  grid.data(vals)
end
doc.render :pdf, filename: "/tmp/sample.pdf", debug: true, logfile: "/tmp/foo.txt"

# end

# end
