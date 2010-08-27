unless defined? APP_CONFIG
  config = YAML.load_file Rails.root.join("config/config.yml")
  APP_CONFIG = config[Rails.env]
end
