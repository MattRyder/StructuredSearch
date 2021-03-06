$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "structured_search/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "structured_search"
  s.version     = StructuredSearch::VERSION
  s.authors     = ["Matt Ryder"]
  s.email       = ["matt@mattryder.co.uk"]
  s.homepage    = "http://www.mattryder.co.uk"
  s.summary     = "Use SQL to query search engines and APIs."
  s.description = s.summary
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "> 4.0"
  
  s.add_development_dependency "coveralls"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "guard-spork"
  s.add_development_dependency "byebug"
  s.add_development_dependency "google_custom_search_api"
end
