# only run in dev branch
branch = `git rev-parse --abbrev-ref HEAD`.chomp
puts "CURRENT BRANCH <#{branch}>"
puts ' TARGET ENVIRONMENT: VAGRANT '.center(70, '-')

abort "EXITING: VAGRANT CAP ONLY RUNS IN MASTER BRANCH" unless branch == "master"

set :stage,     :production
set :user,      'deploy'

set :branch,    'master'

set :rails_env, 'production'

role :app, ['deploy@bugmark.net']
role :db,  ['deploy@bugmark.net']
role :web, ['deploy@bugmark.net']
