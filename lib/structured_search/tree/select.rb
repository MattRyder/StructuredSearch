module StructuredSearch
  module Tree

    ##
    # SELECT reserved word node
    class Select < BaseNode

      # Whether we're using DISTINCT or ALL as a quantifier,
      # DISTINCT performs an extra routine to weed out dupes
      # Set to ALL by default
      attr_accessor :set_quantifier, :search_terms

      def add_search_term(term)
        @search_terms.push term
      end

      def initialize(*argv)
        @search_terms = []
        @set_quantifier = Hash[*argv.flatten][:quantifier] ||= :ALL
        super *argv
      end

    end
  end
end
