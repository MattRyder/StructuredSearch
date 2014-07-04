require 'google_custom_search_api'

module TestSearchProviders
  class GoogleSearchProvider
  
    def self.search(search_term)
      GoogleCustomSearchApi.search(search_term)
    end

  end
end
