source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'dotenv'
gem 'rails', '~> 5.1.2'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'redis', '~> 3.0'
gem 'bcrypt', '~> 3.1.7'
gem 'devise'
gem 'colored'
gem 'whenever'
gem 'github_api'
gem 'nokogiri'

gem 'bootstrap_form'

gem 'mini_portile2'

gem 'slim-rails'                 # slim templates

# Use Capistrano for deployment
gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  # gem 'capybara', '~> 2.13'
  gem 'capybara'
  gem 'selenium-webdriver'
end

# ----- pry production support  -----
gem 'pry-rails'     # upgraded repl
gem 'hirb'

group :development do

  # ----- pry / development support -----
  gem 'pry-doc'                        # doc functions
  gem 'pry-docmore'                    # more doc functions
  gem 'pry-byebug'                     # debugger
  gem 'pry-rescue'                     # opens pry on failing test
  gem 'pry-stack_explorer'             # stack display and navigation

  gem 'guard'                       # auto test-runner
  gem 'guard-rspec_min' , github: 'andyl/guard-rspec_min'
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'       # 'spring rspec' command
  gem 'annotate', require: false   #'be annotate -d; be annotate -p after'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
