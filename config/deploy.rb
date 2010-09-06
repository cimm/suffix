require "bundler/capistrano"

task :production do
  set :application, "suffix"
  set :user, "suffix"
  set :domain, "suffix.be"
  set :rails_env, "production"
  set :repository, "git@github.com:cimm/suffix.git"
  set :branch, "master"
  set :scm, :git
  server domain, :app, :web
  role :db, domain, :primary => true
end

namespace :passenger do
  desc "Restart the Passenger instance."
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

after "deploy:symlink", "crontab:update"

namespace :crontab do
  desc "Update the crontab file."
  task :update do
    run "cd #{release_path} && whenever --update-crontab #{application}"
  end
end
