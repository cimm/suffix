require "bundler/capistrano"

task :production do
  set :application, "suffix"
  set :user, "suffix"
  set :deploy_to, "/home/#{application}/public_html"
  set :domain, "fokkie.be"
  set :rails_env, "production"
  set :scm, :git
  set :repository, "git@github.com:cimm/#{application}.git"
  set :branch, "master"
  set :deploy_via, :remote_cache
  set :use_sudo, false
  set :ssh_options, { :forward_agent => true }
  server domain, :app, :web
  role :db, domain, :primary => true
end

namespace :passenger do
  desc "Restart the Passenger instance."
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

namespace :crontab do
  desc "Update the crontab file."
  task :update do
    run "cd #{release_path} && bundle exec whenever --update-crontab #{application}"
  end
end

namespace :deploy do
  %w(start restart).each { |name| task name do passenger.restart end }
  after "deploy:update_code", "deploy:symlink_stuff"
  after "deploy:symlink", "crontab:update"
  desc "Symlink the config files."
  task :symlink_stuff do
    run "mkdir -p #{shared_path}/config"
    run "mkdir -p #{shared_path}/log"
    run "mkdir -p #{shared_path}/public/assets"
    run "ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -s #{shared_path}/config/config.yml #{release_path}/config/config.yml"
    run "ln -s #{shared_path}/public/assets #{release_path}/public/assets"
  end
end
