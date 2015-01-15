$:.unshift('mindbody-api/lib')
require 'sinatra'
require 'json'
require 'mindbody-api'

include MindBody::Services

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