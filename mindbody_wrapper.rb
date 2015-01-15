$:.unshift('mindbody-api/lib')
require 'sinatra'
require 'json'
require 'mindbody-api'

configure :production do
  require 'newrelic_rpm'
end

include MindBody::Services

class MindBody::Models::Base
	def to_json(options = {})
        hash = {}
        self.instance_variables.each do |var|
            hash[var.to_s[1..-1]] = self.instance_variable_get var
        end
        hash.to_json
	end
end

get '/classes' do
	# Pass along only the accepted MB parameters
	query = params.slice(
		"ClassDescriptionIDs",
		"ClassIDs",
		"StaffIDs",
		"StartDateTime",
		"EndDateTime",
		"ClientID",
		"ProgramIDs",
		"SessionTypeIDs",
		"LocationIDs",
		"SemesterIDs",
		"HideCanceledClasses",
		"SchedulingWindow"
	)

	puts query
	puts params

	# Make the MB API call
	classes = ClassService.get_classes(options=query)

	# Build the response
	content_type :json, 'charset' => 'utf-8'
	status classes.error_code
	headers "Result count" => classes.result_count
	body classes.result[:classes].to_json
end