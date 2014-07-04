module StructuredSearch::Tree
  
  # A statement is a collection of nodes that make up a 
  # single query, such as "SELECT * FROM 'Here', 'There';"
  class Statement < Array

    #:nodoc:
    def initialize(nodes)
      self.concat(nodes)
    end

  end
end
