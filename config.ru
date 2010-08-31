require 'rack/coderay'
use Rack::Coderay, "//pre[@lang]", :line_numbers => :table

require ::File.expand_path('../config/environment',  __FILE__)
run Suffix::Application
