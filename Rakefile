require 'yaml'

config = YAML.load_file('_config.yml')
user   = config['deploy']['user']
path   = config['deploy']['path']
host   = config['deploy']['host']

desc "Generate static site and rsync to webserver"
task :deploy do
  sh "jekyll build"
  sh "rsync --recursive --compress --delete --delete-excluded --exclude 'Gemfile*' --exclude 'Rakefile' -e ssh _site/. #{user}@#{host}:#{path}"
end
