require "bundler/capistrano"

task :production do
  set :application, "suffix"
  set :repository, "git@github.com:cimm/suffix.git"
  set :branch, "master"
  set :scm, :git
  server domain, :app, :web
  role :db, domain, :primary => true
end

after "deploy:symlink", "crontab:update"

namespace :crontab do
  desc "Update the crontab file."
  task :update do
    run "cd #{release_path} && whenever --update-crontab #{application}"
  end
end
