source 'https://rubygems.org'

# git_source(:github) do |repo_name|
#   repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
#   "https://github.com/#{repo_name}.git"
# end

gem 'rails'        , '~> 5.1.3'   # rails
gem 'pg'           , '~> 0.18'    # postgres support
gem 'puma'         , '~> 3.9'     # app server
gem 'sass-rails'   , '~> 5.0'     # javascript support
gem 'uglifier'     , '>= 1.3.0'   # javascript support
gem 'coffee-rails' , '~> 4.2'     # javascript support
gem 'jbuilder'     , '~> 2.5'     # json generator
gem 'redis'        , '~> 3.0'     # redis helper
gem 'bcrypt'       , '~> 3.1.7'   # encryption utilities
gem 'dotenv'                      # hidden files
gem 'hstore_accessor'             # hstore fields
gem 'jsonb_accessor'              # jsonb fields
gem 'colored'                     # colored console text
gem 'octokit'                     # github integration
gem 'faraday-http-cache'          # octokit caching
gem 'graphviz'                    # graph generator
gem 'nokogiri'                    # XML parser
gem 'rails-ujs'                   # javascript support
gem 'jquery-rails'                # javascript support
gem 'bootstrap_form'              # bootstrap form helpers
gem 'mini_portile2'               # package management helpers
gem 'font-awesome-sass'           # fonts
gem 'webpacker'                   # js builder
gem 'devise'                      # authentication
gem 'whenever'                    # cron jobs
gem 'slim-rails'                  # slim templates
gem 'tzinfo-data'                 # timezone support
gem 'paper_trail'                 # model versioning
gem 'acts_as_list'                # sortable lists by position
gem 'bootstrap'                   # twitter bootstrap
gem 'will_paginate'

gem 'grape'
gem 'grape-swagger'
gem 'grape-swagger-rails'

gem 'rack-cors', require: 'rack/cors'

gem 'factory_girl_rails'          # for data loading in production

# ----- pry production support  -----
gem 'pry-rails'     # upgraded repl
gem 'hirb'          # display objects as tables

group :development, :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'vcr'
  gem 'webmock'
  gem 'launchy'
  gem 'rails-erd'    
end

group :development do
  gem 'capistrano-rails'   , group: :development

  # ----- pry / development support -----
  gem 'byebug'                   # debugger
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

