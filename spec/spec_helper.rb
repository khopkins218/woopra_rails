ENV["RAILS_ENV"] ||= 'test'

require 'rubygems'
require 'rspec/autorun'
require 'bundler/setup'
require 'factory_girl_rails'
require 'woopra_rails'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end