source 'https://rubygems.org'

ruby "2.1.1"
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'
gem 'sass-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'bootstrap'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'faker'
gem 'will_paginate'
gem 'will_paginate-bootstrap4'
gem 'bootstrap4-datetime-picker-rails'
gem 'momentjs-rails'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem "omniauth-google-oauth2"
gem 'delayed_job_active_record'
gem "delayed_job_web"

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', '~>0.4.0', require: false
end

# Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'dotenv-rails'
end

group :test do
  gem 'minitest-reporters'
  gem 'guard-minitest'
end

group :production do
  gem 'pg', '0.17.1'
  gem 'rails_12factor', '0.0.2'
end
