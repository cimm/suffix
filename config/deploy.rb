set :application, "suffix"
set :repository, "git@github.com:cimm/suffix.git"
set :branch, "master"
set :scm, :git
server domain, :app, :web
role :db, domain, :primary => true
