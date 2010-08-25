require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env) if defined?(Bundler)

module Suffix
  class Application < Rails::Application
    config.encoding = "utf-8"
    config.time_zone = "Brussels"
    config.filter_parameters += [:password]
  end
end
