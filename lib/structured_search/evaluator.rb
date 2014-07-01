require 'structured_search/errors'

module StructuredSearch

  class Evaluator

    attr_accessor :statements

    def initialize(statements = [])
      @statements = statements
    end

    def exec; end
  
    # evaluates a single statement of a query
    def eval_statement(statement)
      search_terms = []

      statement.each do |node|
        case node.type
        when :SELECT
          search_terms = node.search_terms
        when :FROM
          node.sources.each do |src|
            if !provider_exists? src
              raise UnregisteredProviderError, "#{src} is not found in provider list"
            end
          end
        end


      end

    end


  end
end
