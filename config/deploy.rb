require "bundler/capistrano"

task :production do
  set :application, "suffix"
  set :user, "suffix"
  set :domain, "suffix.be"
  set :rails_env, "production"
  set :scm, :git
  set :deploy_via, :remote_cache
  set :repository, "git@github.com:cimm/suffix.git"
  set :branch, "master"
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
    run "cd #{release_path} && whenever --update-crontab #{application}"
  end
end

namespace :deploy do
  %w(start restart).each { |name| task name do passenger.restart end }
  after "deploy:update_code", "deploy:symlink"
  after "deploy:symlink", "crontab:update"
  desc "Symlink the config files."
  task :symlink do
    run "mkdir -p #{shared_path}/config"
    run "ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -s #{shared_path}/config/config.yml #{release_path}/config/config.yml"
    run "mkdir -p #{shared_path}/config/environments; ln -s #{shared_path}/config/environments/#{rails_env}.rb #{release_path}/config/environments/#{rails_env}.rb"
  end
end
