# foundation tasks
require "capistrano/setup"
require "capistrano/deploy"

# plugin tasks

require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

require "capistrano/bundler"
require "capistrano/rails/assets"
require "capistrano/rails/migrations"

# Load custom tasks from `lib/capistrano/tasks` 
Dir.glob("lib/capistrano/tasks/*.cap").each { |r| import r }
