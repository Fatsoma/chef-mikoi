source 'https://rubygems.org'

gem 'berkshelf', '~> 5.5.0'
gem 'chef', '< 13'

group :test do
  gem 'chefspec', '~> 5.3'
  gem 'cucumber-core', '< 4.0' # pin to fix foodcritic use of tag_expression
  gem 'foodcritic', '~> 6.1'
  gem 'rspec', '~> 3.0'

  gem 'guard-foodcritic', '~> 2.1'
  gem 'guard-rspec', '~> 4.7'

  gem 'rspec_junit_formatter', '0.2.3' # for CircleCI
end

group :integration do
  gem 'busser-serverspec', '0.5.10'
  gem 'kitchen-vagrant', '1.0.0'
  gem 'test-kitchen', '~> 1.15.0'
end
