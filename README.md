# Structured Search     [![Build Status](https://travis-ci.org/MattRyder/StructuredSearch.svg?branch=master)](https://travis-ci.org/MattRyder/StructuredSearch) [![Coverage Status](https://coveralls.io/repos/MattRyder/StructuredSearch/badge.png)](https://coveralls.io/r/MattRyder/StructuredSearch)
StructuredSearch is a Rubygem for querying search engines, APIs and other information providers by using SQL statements (Yeah, just like the ones you use in mySQL! ...kinda)

  - Supports multiple search terms with multiple search providers
  - Customisable provider configurations allow for modifiable COUNT, MAX, MIN methods.
  
## Installing StructuredSearch

    $ gem install structured_search

or in your Gemfile:
    
    gem 'structured_search'
    
## How to use StructuredSearch
There are two path you can go by, the easiest method is to just pass your input and your list of providers into the `evaluate` method:

```ruby
    require 'structured_search'

    # a hash of your providers, the key should be the same case as
    # seen in your input, and the values are classes that contain the
    # class method 'search'.
    providers = {
      :Google => MySearchProviders::GoogleSearchClass,
      :Github => GithubApi::StructuredSearchProviderClass
    }

    # the SQL string to evaluate
    search_query = "SELECT 'Matz', 'Ruby' FROM 'Google';"

    results = StructuredSearch.evaluate(search_query, providers)

    # and read your results:
    # they're contained in an array (each statement), addressed by
    # the provider (i.e. Google) and then by search term
    ruby_google_results = results[0]['Google']['Ruby']
```
## License
MIT

### About StructuredSearch
Developed by [Matt Ryder](http://mattryder.co.uk), please email/tweet me if you see anything missing or erroneous about StructuredSearch.
