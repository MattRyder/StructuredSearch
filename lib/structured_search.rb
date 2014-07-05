require 'structured_search/lexer'
require 'structured_search/parser'
require 'structured_search/evaluator'
require 'structured_search/errors'
require 'structured_search/patterns'
require 'structured_search/token'
require 'structured_search/base_node'

module StructuredSearch
  class << self

    # Creates an evaluator instance, with a given input and provider hash
    # and returns the evaluator result.
    # Params:
    # +input+:: Input string to parse and evaluate.
    # +providers+:: The search provider keys and classes.
    def evaluate(input, providers)
      parser = StructuredSearch::Parser.new(input, providers)
      parser.parse_to_end
      @evaluator = StructuredSearch::Evaluator.new(parser.statements)
      @evaluator.eval if @evaluator
    end

  end
end
