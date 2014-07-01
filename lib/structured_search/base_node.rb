module StructuredSearch
  module Tree

    class BaseNode
      attr_accessor :line, :column, :type

      def initialize(topts = {})
        topts.each { |key, val| send "#{key}=", val }
      end
    end

    # require all parse tree files
    Dir[File.expand_path("../tree/*", __FILE__)].each { |f| require f }

  end
end
