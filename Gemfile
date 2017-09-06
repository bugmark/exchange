source 'https://rubygems.org'

# git_source(:github) do |repo_name|
#   repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
#   "https://github.com/#{repo_name}.git"
# end

gem 'rails'       , '~> 5.1.3'
gem 'pg'          , '~> 0.18'
gem 'puma'        , '~> 3.9'
gem 'sass-rails'  , '~> 5.0'
gem 'uglifier'    , '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder'    , '~> 2.5'
gem 'redis'       , '~> 3.0'
gem 'bcrypt'      , '~> 3.1.7'
gem 'dotenv'
gem 'hstore_accessor'
gem 'jsonb_accessor'
gem 'colored'

gem 'octokit'
gem 'faraday-http-cache'

gem 'nokogiri'
gem 'rails-ujs'
gem 'jquery-rails'
gem 'bootstrap_form'
gem 'mini_portile2'
gem 'font-awesome-sass'
gem 'webpacker'                    # js builder
gem 'devise'                       # authentication
gem 'whenever'                     # cron jobs
gem 'slim-rails'                   # slim templates

# ----- pry production support  -----
gem 'pry-rails'     # upgraded repl
gem 'hirb'          # display objects as tables

# ----- deployment -----
gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'selenium-webdriver'
end

group :development do

  # ----- pry / development support -----
  gem 'pry-doc'                  # doc functions
  gem 'pry-docmore'              # more doc functions
  gem 'pry-byebug'               # debugger
  gem 'pry-rescue'               # opens pry on failing test
  gem 'pry-stack_explorer'       # stack display and navigation
  gem 'web-console', '>= 3.3.0'  # IRB on exception pages or with <%= console %>

  gem 'spring'
  gem 'guard'                    # auto test-runner
  gem 'spring-commands-rspec'    # 'spring rspec' command
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'guard-rspec_min'      , github: 'andyl/guard-rspec_min'
  gem 'listen'               , '>= 3.0.5', '< 3.2'
  gem 'annotate', require: false   #'be annotate -d; be annotate -p after'
end

gem 'tzinfo-data'
