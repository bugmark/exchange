puts ' CAP CONFIG BASE '.center(70,'-')

# ===== App Config =====

set :application,    'bugmark'

set :log_level,      :error                 # use :error, :warn, :info, or :debug
set :format_options, command_output: false  # :stdout, :stderr, true, false

set :deploy_to,   -> { "/home/#{fetch(:user)}/run/#{fetch(:application).downcase}" }

# ===== Nginx Config =====

set :vhost_names, %w(bugmark.net *.issuemark.net)
set :web_port,    8500

# ===== Source Access =====

set :repo_url,         'https://github.com/mvscorg/bugmark.git'

# ===== Tasks =====

after 'deploy:symlink:shared', 'data:rsync'
after 'deploy:symlink:shared', 'data:varfile'
after 'bundler:install'      , 'assets:precompile'

# ===== Symlinking =====

set :linked_dirs,  %w{data log tmp/pids tmp/cache tmp/sockets public/all_packs public/util public/system public/assets}

# ===== Bundler =====

set :bundle_flags,    '--deployment --quiet'
set :bundle_without,  'development test'
set :bundle_gemfile,  -> { release_path.join('Gemfile') }
set :bundle_dir,      -> { shared_path.join('bundle')   }
set :bundle_roles,    :all

# ===== Misc Config =====

set :keep_releases, 5
set :default_env        , { 'RAILS_ENV' => 'production' }
set :default_environment, { 'RAILS_ENV' => 'production' }

# ===== Deploy Tasks =====

namespace :deploy do

  desc 'Restart application'
  task :restart do
    invoke 'systemd:export'
    on roles(:app) do
      debug ' RESTART '.center(80,'-')
      debug ' TODO: FIX THE BROKEN KILL SIGNALS '.center(80,'-')
      # restart PUMA
      execute "sudo systemctl restart bugmark"
      # execute "sudo systemctl restart sidekiq"
    end
  end

  after  :publishing , :restart
  after  :finishing  , :cleanup
  after  :cleanup    , 'systemd:symlink_logs'

end
