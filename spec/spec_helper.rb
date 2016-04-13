require 'safe_yaml'
SafeYAML::OPTIONS[:default_mode] = :safe

require 'chefspec'
require 'chefspec/berkshelf'
require 'chefspec/cacher'
ChefSpec::Coverage.start! if ENV['COVERAGE']

require 'pry'

RSpec.configure do |config|
  config.mock_with :rspec
  config.filter_run :focus if ENV['FOCUS']
  config.run_all_when_everything_filtered = true

  config.role_path = File.expand_path('../roles', __FILE__)
end
