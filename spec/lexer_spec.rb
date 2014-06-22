require 'spec_helper'
require 'structured_search/lexer'
require 'structured_search/patterns'

describe "Lexer" do

  before (:each) do
    @input = "SELECT * FROM 'Google';"
    @lexer = StructuredSearch::Lexer.new(@input)
  end

  it "should return a list of lexer patterns" do
    patterns = StructuredSearch::Lexer::PATTERNS
    expect(patterns)
  end

  it "should return a new lexer object" do
    expect(@lexer).to be_a(StructuredSearch::Lexer)
  end

  it "should return a lexer with correct input and defaults" do
    test_state = @lexer.state
    expect(test_state[:input]).to eq(@input)
    expect(test_state[:column]).to eq(1)
    expect(test_state[:line]).to eq(1)
  end

  it "should scan an entire input string" do
    expect(@lexer.scan).to be_a(StructuredSearch::Token)
  end

  it "should return SELECT as the first token" do
    token = @lexer.scan
    expect(token.token.to_sym).to eq(:SELECT)
  end

  it "should return the correct position in the offset" do
    @lexer.scan
    expect(@lexer.lexer_offset).to eq("SELECT".size)
  end

  it "should extract every token in the input" do
    tokens = []
    while @lexer.scan(true); tokens.push @lexer.scan; end
    expect(tokens.size).to eq(5)
  end

end
