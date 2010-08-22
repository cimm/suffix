namespace :photos do

  desc "Removes the old photos cache and creates a new one"
  task :refresh => :environment do
    include ActionDispatch::Routing::UrlFor
    include Rails.application.routes.url_helpers
    default_url_options[:host] = APP_CONFIG['host']
    ActionController::Base.new.expire_fragment(:latest)
    require 'open-uri'
    open(photos_url)
  end

end
