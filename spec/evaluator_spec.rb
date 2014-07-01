require 'spec_helper'
require 'structured_search/evaluator'
require_relative './support/GoogleSearchProvider'

describe "Evaluator" do

  before(:each) do

    providers = { Google:  TestSearchProviders::GoogleSearchProvider }
    query = "SELECT 'Ruby' FROM 'Google'"
    lexer = StructuredSearch::Lexer.new(query)
    
    @parser = StructuredSearch::Parser.new(lexer, providers)
    @parser.parse_to_end
    
    @evaluator = StructuredSearch::Evaluator.new(@parser.statements)
  end

  it "should evaluate every statement in a query" do
    result = @evaluator.exec   
  end
    


end
