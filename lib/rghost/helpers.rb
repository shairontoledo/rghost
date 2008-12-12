module RGhost::UnlessHelpers #:nodoc:
  module HashKeyMethod #:nodoc:
    def method_missing(method, *args)
      self[method.to_sym]   
    end
  end
  
  class HashKeyMethodClass < Hash #:nodoc:
    include HashKeyMethod
  end


end