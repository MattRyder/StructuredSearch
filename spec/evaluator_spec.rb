require 'spec_helper'
require 'structured_search/evaluator'
require_relative './support/GoogleSearchProvider'
require_relative './support/ErroneousSearchProvider'

describe "Evaluator" do

  before(:each) do

    providers = { Google:  TestSearchProviders::GoogleSearchProvider }
    query = "SELECT 'Ruby', 'Montreal' FROM 'Google'"
    
    @parser = StructuredSearch::Parser.new(query, providers)
    @parser.parse_to_end
    
    @evaluator = StructuredSearch::Evaluator.new(@parser.statements)
  end

  it "should evaluate a single statement" do
    result = @evaluator.eval_statement(@parser.statements[0])

    expect(result.count).to eq(1) # result comes from 1 provider
    expect(result["Google"].count).to eq(2) # result built from 2 search terms
  end

  it "should throw an error because ErroneousSearchProvider#search doesn't exist" do
    query = "SELECT 'failure' FROM 'ErrorProvider'"
    parser = StructuredSearch::Parser.new(query, {
      ErrorProvider: TestSearchProviders::ErroneousSearchProvider
    })
    parser.parse_to_end

    evaluator = StructuredSearch::Evaluator.new(parser.statements)
    expect{evaluator.eval}.to raise_error(StructuredSearch::ProviderNotAvailableError)
  end

end
