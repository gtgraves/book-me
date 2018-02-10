source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

group :development do
  gem 'sqlite3'
  gem 'web-console', '~> 2.0'
  gem 'listen'
  gem 'letter_opener'
end

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'bootstrap', '~> 4.0.0'
gem 'figaro'
gem 'devise'
gem 'pundit'

group :development, :test do
  gem 'byebug'
  gem 'spring'
  gem 'rspec-rails'
  gem 'rails-controller-testing'
  gem 'shoulda'
  gem 'faker'
  gem 'factory_bot_rails', '~> 4.0'
  gem 'pry-rails'
end
