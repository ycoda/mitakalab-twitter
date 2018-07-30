# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "mitakalab-twitter"
set :repo_url, "git@github.com:ycoda/mitakalab-twitter.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :branch, 'master'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/ycoda/workspace/mitakalab-twitter"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/master.key"
namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:start'
  end

  desc 'Upload database.yml'
  task :upload do
    on roles(:app) do
      if test "[ ! -d #{shared_path}/config ]"
        execute "mkdir -p #{shared_path}/config"
      end
      upload!('config/database.yml', "#{shared_path}/config/database.yml")
    end
  end

  before :starting, 'deploy:upload'
  after :finishing, 'deploy:cleanup'
end
# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/home/ycoda/.rbenv:$PATH" }
# set :default_env, { path: "/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH" }
set :defautl_env, {
  rbenv_root: "/home/ycoda/.rbenv/bin/rbenv",
  path: "/home/ycoda/.rbenv/shims/ruby"
}

# Default value for local_user is ENV['USER']
set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 3

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

# rbenvの設定
set :rbenv_type, :system
set :rbenv_ruby, '2.5.1'
# set :rbenv_path, '/home/ycoda/.rbenv'
set :rbenv_type, :ycoda
set :rbenv_ruby, '2.5.1'
set :rbenv_path, '~/.rbenv'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} /home/ycoda/.rbenv/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

server "sanpo.work",
  user: "ycoda",
  roles: %w{web app},
  ssh_options: {
    # user: "user_name", # overrides user setting above
    keys: %w(/home/ycoda/.ssh/sakura_debian_rsa),
    forward_agent: true,
    auth_methods: %w(publickey),
    # password: "please use keys"
    port: 1234
  }


# deployするときのUser名（サーバ上にこの名前のuserが存在しAccessできることが必要）
set :user ,        'deployer'

set :puma_threds,  [4, 16]
set :puma_workers, 0
set :pty, true

set :deploy_via, :remote_cache

# deploy先サーバにおく場所

set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "var/log/puma.error.log"
set :puma_error_log,  "var/log/puma.access.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord

# set :keep_releases, 2

# namespace :puma do
#   desc 'Create Directories for Puma Pids and Socket'
#   task :make_dirs do
#     on roles(:app) do
#       execute "mkdir #{shared_path}/tmp/sockets -p"
#       execute "mkdir #{shared_path}/tmp/pids -p"
#     end
#   end
#
#   before :start, :make_dirs
# end
#
# namespace :deploy do
#   desc "Make sure local git is in sync with remote."
#   task :check_revision do
#     on roles(:app) do
#       unless `git rev-parse HEAD` == `git rev-parse origin/master`
#         puts "WARNING: HEAD is not the same as origin/master"
#         puts "Run `git push` to sync changes."
#         exit
#       end
#     end
#   end
#
#   desc 'Initial Deploy'
#   task :initial do
#     on roles(:app) do
#       before 'deploy:restart', 'puma:start'
#       invoke 'deploy'
#     end
#   end
#
#   desc 'Restart application'
#   task :restart do
#     on roles(:app), in: :sequence, wait: 5 do
#       invoke 'puma:restart'
#     end
#   end
# end
