require "rghost/ps_object"
#Specifiesnew  DSC (Document Structuring Conventions)
class RGhost::DSCEntry < RGhost::PsObject
  #===Example
  #   DSCEntry.new do |entry|
  #     entry << "BoundingBox: 0 0 612 792"
  #     entry << "Pages: 45"
  #     entry << "BeginSetup"
  #   end
  def initialize
		
    yield @entries=[]
  end

  def ps
    @entries.map{|e| "%%#{e}\n"}.to_s

  end
	
end
