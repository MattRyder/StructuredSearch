module StructuredSearch
  module Tree

    ##
    # FROM reserved word node
    class From < BaseNode

      # in sql spec, this is where we store all the
      # derived columns, such as Google, Omniref etc
      #
      # This is a hash containing the symbol reference
      # and a class reference to what generates the query
      attr_accessor :sources

      def initialize(*argv)
        @sources = {}
        super *argv
      end

    end

  end
end
