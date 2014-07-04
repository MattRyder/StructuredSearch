module StructuredSearch
  module Tree

    # The base of any node in the AST, it stores the line, 
    # column and type of token.
    class BaseNode

      #+line+:: The line this AST node was found
      #+column+:: The column this AST node was found
      #+type+:: Holds the type of node for fast lookup
      attr_accessor :line, :column, :type

      # sends each token value to it's respective attribute
      def initialize(topts = {})
        topts.each { |key, val| send "#{key}=", val }
      end
    end

    # require all parse tree files
    Dir[File.expand_path("../tree/*", __FILE__)].each { |f| require f }

  end
end
