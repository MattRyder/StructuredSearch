module StructuredSearch
  module Tree

    ##
    # Asterisk (*) node
    class Asterisk < BaseNode

      def initialize(*argv)
        super *argv
      end


    end

  end
end