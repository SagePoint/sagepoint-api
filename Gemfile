source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use mysql as the database for Active Record
gem 'mysql2'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
#gem 'coffee-rails', '~> 4.0.0'

gem 'execjs'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby


gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem 'protected_attributes'


# Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# Authentication gem - now works with Rails 4! =D
gem 'devise', '3.2.0'
gem 'dalli'

gem 'rack-cors', :require => 'rack/cors'
gem 'whenever', :require => false

gem 'rubyfish'
gem 'whenever'

gem 'wirble', :group => :development
gem 'jazz_hands', :group => :development

gem 'airbrake'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
group :development do
  gem 'capistrano',          :require => nil
  gem 'capistrano-notifier', :require => nil
  gem 'mailcatcher',         :require => nil
  gem 'foreman',             :require => nil
end
