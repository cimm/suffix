require 'rack/coderay'
use Rack::Coderay, "//code[@lang]", :line_numbers => :table

require ::File.expand_path('../config/environment',  __FILE__)
run Suffix::Application
