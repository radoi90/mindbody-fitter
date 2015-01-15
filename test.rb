ENV['RACK_ENV'] = 'test'

require 'minitest/pride'
require 'minitest/autorun'
require 'rack/test'
require_relative 'vcr_setup.rb'
require_relative 'mindbody_wrapper.rb'

include Rack::Test::Methods

def app
	Sinatra::Application
end

describe "Mindbody Wrapper" do

	it "should return json to classes" do
		VCR.insert_cassette 'mindbody-classes'

		get '/classes'
		last_response.headers['Content-Type'].must_equal 'application/json;charset=utf-8'

		VCR.eject_cassette
	end

	it "should return 12 classes for current day" do
		VCR.insert_cassette 'mindbody-classes-today'

		get '/classes'
		last_response.headers['Result count'].to_i.must_equal 12

		VCR.eject_cassette
	end

	it "should return 85 classes for current week" do
		VCR.insert_cassette 'mindbody-classes-this-week'

		get '/classes?StartDateTime=2015-01-15T07:35:32&EndDateTime=2015-01-22T07:35:32'
		last_response.headers['Result count'].to_i.must_equal 85

		VCR.eject_cassette
	end
end