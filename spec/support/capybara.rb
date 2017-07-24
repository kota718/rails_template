require 'capybara/dsl'
require 'capybara/rspec'
require 'capybara/webkit'

RSpec.configure do |config|
  config.include Capybara::DSL
end
