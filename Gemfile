source 'https://rubygems.org'

gem 'jruby-openssl', :platforms => :jruby
gem 'rake'
gem 'yard'
gem 'sawyer', :git => "https://github.com/lostisland/sawyer.git"

group :development do
  gem 'kramdown'
  gem 'pry'
end

group :test do
  gem 'coveralls', :require => false
  gem 'guard-rspec'
  gem 'json', '~> 1.7', :platforms => [:ruby_18, :jruby]
  gem 'rspec', '>= 2.11'
  gem 'simplecov', '~> 0.7.1', :require => false
  gem 'webmock'
end

gemspec
