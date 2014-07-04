require 'structured_search/errors'

module StructuredSearch

  class Evaluator

    attr_accessor :statements

    def initialize(statements = [])
      @statements = statements
    end

    def eval
      results = []

      @statements.each do |s|
        st_res = eval_statement(s)
        results << st_res if st_res
      end
      results
    end
  
    # evaluates a single statement of a query
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
