require 'rack/coderay'
use Rack::Coderay, "//code[@lang]"

require ::File.expand_path('../config/environment',  __FILE__)
run Suffix::Application
