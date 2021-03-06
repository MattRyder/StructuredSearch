require 'rubygems'
require 'spork'
require 'byebug'
require 'coveralls'

Spork.prefork do
  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'
  
  require File.expand_path("../dummy/config/environment", __FILE__)
  require 'rspec/rails'

  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
  ActiveRecord::Migration.maintain_test_schema!
  
  # boot up coveralls for code coverage:
  Coveralls.wear!

  RSpec.configure do |config|
    config.infer_spec_type_from_file_location!
  end
end

Spork.each_run do
end


RSpec.configure do |config|
  config.color = true
  config.tty = true
  config.formatter = :documentation
  config.drb = true
end
