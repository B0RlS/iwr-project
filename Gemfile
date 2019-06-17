# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.5'

# Rails defaults
gem 'bootsnap', '>= 1.1.0', require: false
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.3'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails', '~> 3.8'
  gem 'rubocop'
end
group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end
group :test do
  gem 'capybara', '>= 2.15'
  gem 'chromedriver-helper'
  gem 'selenium-webdriver'
end

# IWR gems
gem 'active_storage_validations'
gem 'activestorage'
gem 'bcrypt', '>= 3.1.12'
gem 'bootstrap'
gem 'country_select', '~> 4.0'
gem 'font-awesome-rails'
gem 'google-cloud-storage', '~> 1.8', require: false
gem 'gravatar_image_tag'
gem 'image_processing', '~> 1.2'
gem 'jquery-rails'
gem 'mini_magick'
gem 'pundit'
gem 'rubocop-rails'
gem 'slim-rails'
gem 'travis'
group :development, :test do
  # Enter your gem
end
group :development do
  # Enter your gem
end
group :test do
  # Enter your gem
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
  gem 'shoulda-matchers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
