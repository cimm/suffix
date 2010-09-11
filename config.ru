require 'rack/coderay'
use Rack::Coderay

require ::File.expand_path('../config/environment',  __FILE__)
run Suffix::Application
