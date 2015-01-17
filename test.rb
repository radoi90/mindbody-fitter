ENV['RACK_ENV'] = 'test'

require 'minitest/pride'
require 'minitest/autorun'
require 'rack/test'
require_relative 'vcr_setup.rb'
require_relative 'mindbody_wrapper.rb'

require_relative 'test_classes.rb'
require_relative 'test_sites.rb'

include Rack::Test::Methods

def app
	Sinatra::Application
end