require 'spec_helper'
require 'structured_search/token'

describe "Token" do

  it "should return an empty default token" do
    expect(StructuredSearch::Token.new).to be_a(StructuredSearch::Token)
  end

  before(:each) do
    hash = { token: :SELECT, lexeme: "SELECT", line: 1, column: 1 }
    @token = StructuredSearch::Token.new(hash)
  end

  it "should store a hash correctly" do
    expect(@token.token).to eq(:SELECT)
    expect(@token.lexeme).to eq("SELECT")
    expect(@token.line).to eq(1)
    expect(@token.column).to eq(1)
  end

  it "should return the token as a human-readable string" do
    exp_str = "SELECT: 'SELECT' (Line 1, Column 1)"
    expect(@token.to_s).to eq(exp_str)
  end

end
