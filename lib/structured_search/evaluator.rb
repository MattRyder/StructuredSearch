require 'structured_search/errors'

module StructuredSearch

  # Evaluates one or more statements that make up a query.
  # Each statement is made up of a series of AST nodes produced 
  # by the parser, from input generated by the lexer.
  class Evaluator

    # statements to be evaluated
    attr_accessor :statements

    #:nodoc:
    def initialize(statements = [])
      @statements = statements
    end

    # Evaluate every statement given to the initializer. 
    # Returns:
    # +result+:: An array containing the result of each statement
    def eval
      results = []

      @statements.each do |s|
        st_res = eval_statement(s)
        results << st_res if st_res
      end
      results
    end
  
    # Evaluates a single statement.
    # Returns:
    # +result+:: An array containing the result of the statement
    def eval_statement(statement)
      search_terms = results = []

      statement.each do |node|
        
        case node.type
        when :SELECT
          search_terms = node.search_terms
        when :FROM
          results = provider_lookup(node, search_terms)
        when :WHERE
          node.constraints.each do
            # results = send :method, results (or something like that)
          end
        end
      end

      results
    end

private

    # Performs a search operation, looking up each search term 
    # on each provider (by way of Provider#search), and storing it in a Hash.
    # Parameters:
    # +node+:: The FROM node that contains search provider sources
    # +search_terms+:: The search terms from a SELECT node, as an array
    # Returns:
    # +provider_results+::A Hash that contains the provider as a key, and the
    # search term as a value, which can be used to lookup the result via 
    # 'result[:provider][:search_term]'.
    def provider_lookup(node, search_terms)
      provider_results = {}
      search_results = {}

      node.sources.each do |provider, prov_class|
        if prov_class.respond_to? :search
          search_terms.each do |search_term|
            search_result = prov_class.send :search, search_term
            search_results[search_term] = search_result if search_result
          end

          provider_results[provider] = search_results

        else
          raise ProviderNotAvailableError, "Method 'search' not available for provider #{provider}"
        end
      end

      provider_results
    end



  end
end
