require 'spec_helper'
require_relative './support/GoogleSearchProvider'

describe "StructuredSearch" do

  before(:each) do
    query = "SELECT 'Futurama', 'The Simpsons' FROM 'Google'";
    providers = { Google: TestSearchProviders::GoogleSearchProvider }
    @results = StructuredSearch.evaluate(query, providers)
  end

  it "should return Google Search results for 'Futurama' and 'The Simpsons'" do
    expect(@results[0]['Google']['Futurama'].count > 0).to eq(true)
    expect(@results[0]['Google']['The Simpsons'].count > 0).to eq(true)
  end


end
