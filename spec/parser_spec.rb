require 'spec_helper'
require 'structured_search/lexer'
require 'structured_search/parser'
require 'structured_search/patterns'

describe "Parser" do

  before (:each) do
    providers = { Google:  TestSearchProviders::GoogleSearchProvider }
    lexer = StructuredSearch::Lexer.new("SELECT 'Array', 'Hash' FROM 'Google';")
    @parser = StructuredSearch::Parser.new(lexer, providers)
  end

  it "should create an object of correct type" do
    expect(@parser).to be_a(StructuredSearch::Parser)
  end

  # peek thrice to ensure it doesn't move
  # surely can be more thorough w/o lexer as attr?
  it "should peek at the token" do
    3.times do
      token = @parser.peek_token
      expect(token.token).to eq(:SELECT)
    end
  end

  it "should parse a correct token" do
    token = @parser.parse
    expect(token).to be_a(StructuredSearch::Tree::Select)
  end

  # SELECT et FROM
  it "should parse until the end of input" do
    @parser.parse_to_end
    expect(@parser.statements.count).to eq(1)
    expect(@parser.statements[0].count).to eq(2)
  end

  it "should intern the correct token attributes" do
    sel_node = @parser.parse
    # lets ensure that it's a select before using it
    expect(sel_node).to be_a(StructuredSearch::Tree::Select)

    # set quantifier should be ALL, as none is given
    expect(sel_node.set_quantifier).to eq(:ALL)
    expect(sel_node.search_terms).to contain_exactly('Array', 'Hash')
  end

end
