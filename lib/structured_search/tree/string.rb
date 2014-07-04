module StructuredSearch
  module Tree

    # Represents a string node, 'Google', 'SearchThisString' etc.
    class String < BaseNode

      #:nodoc:
      def initialize(*argv)
        super *argv
      end

    end

  end
end
