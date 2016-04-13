source 'https://rubygems.org'

gem 'berkshelf', '~> 4.3.2'

group :test do
  gem 'foodcritic', '~> 6.1'
  gem 'rspec', '~> 3.0'
  gem 'chefspec', '~> 4.0'

  gem 'guard-rspec', '~> 4.6'
  gem 'guard-foodcritic', '~> 2.1'

  gem 'rspec_junit_formatter', '0.2.3' # for CircleCI
end

group :integration do
  gem 'test-kitchen', '~> 1.7.2'
  gem 'kitchen-vagrant', '0.20.0'
  gem 'busser-serverspec', '0.5.9'
end
