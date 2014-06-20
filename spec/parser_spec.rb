require 'spec_helper'
require 'structured_search/lexer'
require 'structured_search/parser'
require 'structured_search/patterns'

describe "Parser" do

  before (:each) do
    lexer = StructuredSearch::Lexer.new("SELECT * FROM 'RubyDoc';")
    @parser = StructuredSearch::Parser.new(lexer)
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

  # right now (SELECT, ASTERISK, FROM, STRING)
  it "should parse until the end of input" do
    @parser.parse_to_end
    expect(@parser.nodes.count).to eq(4)
  end

end
