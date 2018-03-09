# only run in dev branch
branch = `git rev-parse --abbrev-ref HEAD`.chomp
puts "CURRENT BRANCH <#{branch}>"
puts ' TARGET ENVIRONMENT: PRODUCTION '.center(70, '-')

abort "EXITING: VAGRANT CAP ONLY RUNS IN MASTER BRANCH" unless branch == "master"

set :stage,     :production
set :user,      'deploy'

set :branch,    'master'

set :rails_env, 'production'

role :app, %w(deploy@bugmark.net deploy@demo.bugmark.net deploy@blockcve.bugmark.net)
role :db,  %w(deploy@bugmark.net deploy@demo.bugmark.net deploy@blockcve.bugmark.net)
role :web, %w(deploy@bugmark.net deploy@demo.bugmark.net deploy@blockcve.bugmark.net)

