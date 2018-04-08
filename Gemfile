source 'https://rubygems.org'

ruby '2.2.10'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~>5.0.7'

gem 'pg'
gem 'devise'
gem 'cancancan'
#
# # Use SCSS for stylesheets
gem 'sass-rails'

# # Use Uglifier as compressor for JavaScript assets
gem 'uglifier'

# # Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails'

# # See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# # Use jquery as the JavaScript library
gem 'jquery-rails'

# # Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

gem 'annotate'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem 'bootstrap-sass'
group :development do
  gem 'rails_layout'
  gem 'letter_opener'
end

group :test do
#   gem 'minitest'
  gem 'capybara-email'
  gem 'selenium-webdriver'
  gem 'capybara-webkit'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'shoulda-matchers', "< 3.0.0", :require => false
  gem 'rspec-activemodel-mocks'
  gem 'rails-controller-testing'
end

group :development, :test do
  gem 'rspec-expectations'
  gem 'rspec-its'
  gem 'rspec-rails'
  gem 'cucumber-rails', :require => false
  gem 'factory_bot_rails'
end

## these were never enabled

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
