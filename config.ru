require 'rack/codehighlighter'
use Rack::Codehighlighter, :coderay, :element => "code", :pattern => /\A:::(\w+)\s*\n/

require ::File.expand_path('../config/environment',  __FILE__)
run Suffix::Application
