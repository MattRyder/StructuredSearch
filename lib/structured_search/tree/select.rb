module StructuredSearch
  module Tree

    ##
    # SELECT reserved word node
    class Select < BaseNode

      # +set_quantifier+:: Whether this search uses ALL or DISTINCT
      # +search_terms+:: The search terms we're looking for
      attr_accessor :set_quantifier, :search_terms

      # Sets the set quantifier (either ALL or DISTINCT) for this statement
      def set_quantifier=(quantifier)
        if [:ALL, :DISTINCT].include? quantifier
          @set_quantifier = quantifier
        end
      end

      # Adds a search term to the list of terms
      def add_search_term(term)
        @search_terms.push term
      end

      #:nodoc:
      def initialize(*argv)
        @search_terms = []
        @set_quantifier = :ALL
        super *argv
      end

    end
  end
end
