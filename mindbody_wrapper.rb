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

class MindBody::Services::ClassService
      operation :add_clients_to_classes
end

get '/' do
	stevie_j_quotes = [
		"Don’t let the noise of others’ opinions drown out your own inner voice.",
		"Have the courage to follow your heart and intuition. They somehow already know what you truly want to become. Everything else is secondary.",
		"Sometimes life's going to hit you in the head with a brick. Don't lose faith. I'm convinced that the only thing that kept me going was that I loved what I did.",
		"Why join the navy if you can be a pirate?",
		"Taking LSD was a profound experience, one of the most important things in my life. LSD shows you that there’s﻿ another side to the coin, and you can’t remember it when it wears off, but you know it. It reinforced my sense of what was important—creating great things instead of making money, putting things back into the stream of history and of human consciousness as much as I could.",
		"The heaviness of being successful was replaced by the lightness of being a beginner again.",
		"The only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle.",
		"Your time is limited, so don't waste it living someone else's life. Don't be trapped by dogma - which is living with the results of other people's thinking. Don't let the noise of others' opinions drown out your own inner voice. And most important, have the courage to follow your heart and intuition.",
		"For the past 33 years, I have looked in the mirror every morning and asked myself: 'If today were the last day of my life, would I want to do what I am about to do today?' And whenever the answer has been 'No' for too many days in a row, I know I need to change something.",
		"Everyone here has the sense that right now is one of those moments when we are influencing the future.",
		"Innovation distinguishes between a leader and a follower.",
		"My favorite things in life don't cost any money. It's really clear that the most precious resource we all have is time.",
		"Be a yardstick of quality. Some people aren't used to an environment where excellence is expected.",
		"Design is not just what it looks like and feels like. Design is how it works.",
		"Sometimes when you innovate, you make mistakes. It is best to admit them quickly, and get on with improving your other innovations.",
		"Stay hungry, stay foolish.",
		"Computers themselves, and software yet to be developed, will revolutionize the way we learn.",
		"Design is a funny word. Some people think design means how it looks. But of course, if you dig deeper, it's really how it works.",
		"There's one more thing..."
	]

	stevie_j_quotes.sample + " - Steve Jobs"
end

get '/classes' do
	# Pass along only the accepted MB parameters
	query = params.slice(
		"ClassIDs",
		"StartDateTime",
		"EndDateTime",
		"LocationIDs",
		"PageSize",
		"CurrentPageIndex"
	)

	# For parameters that accept multiple ids, split values and convert to integer
	query["ClassIDs"] && query["ClassIDs"] = query["ClassIDs"].split(",")
	query["LocationIDs"] && query["LocationIDs"] = query["LocationIDs"].split(",")

	# Make the MB API call
	classes = ClassService.get_classes(options=query)
	response = Array(classes.result[:classes])

	# Build the response
	content_type :json, 'charset' => 'utf-8'
	status classes.error_code
	headers "Result count" => response.size.to_s
	body response.to_json
end

get '/classes/add_client' do
	# Pass along only the accepted MB parameters
	query = params.slice(
		"ClientID",
		"ClassIDs",
		"Test",
		"RequirePayment"
	)

	unless query["ClientID"] && query["ClassIDs"] && query["Test"] && query["RequirePayment"]
		return [400, {"Content-Type" => 'application/json;charset=utf-8'},
			{error_message: "ClientID, ClassIDs, Test, RequirePayment required."}.to_json]
	end

	# Massage parameters
	query["ClientIDs"] = {"string" => query["ClientID"] }
	query["ClassIDs"] = query["ClassIDs"].split(",")

	puts 'here'
	puts query

	# Make the MB API call
	booked_classes = ClassService.add_clients_to_classes(options=query)
	response = booked_classes.result[:classes]

	# Build the response
	content_type :json, 'charset' => 'utf-8'
	status booked_classes.error_code
	headers "Result count" => response.size.to_s
	body response.to_json
end

get '/sites' do
	# Pass along only the accepted MB parameters
	query = params.slice("PageSize","CurrentPageIndex")

	# Make the MB API call
	sites = SiteService.get_sites(options=query)
	response = Array(sites.result[:sites])

	# Build the response
	content_type :json, 'charset' => 'utf-8'
	status sites.error_code
	headers "Result count" => response.size.to_s
	body response.to_json
end

get '/locations' do
	# Make the MB API call
	locations = SiteService.get_locations()
	response = Array(locations.result[:locations])

	# Build the response
	content_type :json, 'charset' => 'utf-8'
	status locations.error_code
	headers "Result count" => response.size.to_s
	body response.to_json
end

get '/packages' do
	# Make the MB API call
	packages = SaleService.get_packages()
	response = Array(packages.result[:packages])

	# Build the response
	content_type :json, 'charset' => 'utf-8'
	status packages.error_code
	headers "Result count" => response.size.to_s
	body response.to_json
end

get '/products' do
	# Make the MB API call
	products = SaleService.get_products()
	response = Array(products.result[:products])

	# Build the response
	content_type :json, 'charset' => 'utf-8'
	status products.error_code
	headers "Result count" => response.size.to_s
	body response.to_json
end

get '/services' do
	# Make the MB API call
	services = SaleService.get_services()
	response = Array(services.result[:services])

	# Build the response
	content_type :json, 'charset' => 'utf-8'
	status services.error_code
	headers "Result count" => response.size.to_s
	body response.to_json
end

get '/clients' do
	# Pass along only the accepted MB parameters
	query = params.slice(
		"ClientIDs",
		"SearchText",
		"PageSize",
		"CurrentPageIndex"
	)

	# For parameters that accept multiple ids, split values and convert to integer
	query["ClientIDs"] && query["ClientIDs"] = query["ClientIDs"].split(",")

	# get_clients needs the dev account credentials
	query["UserCredentials"] = {
		"Username" => "Siteowner",
		"Password" => "apitest1234",
		"SiteIDs" => {
			"int" => -99
		}
 	}

	# Make the MB API call
	clients = ClientService.get_clients(options=query)
	response = Array(clients.result[:clients])

	# Build the response
	content_type :json, 'charset' => 'utf-8'
	status clients.error_code
	headers "Result count" => response.size.to_s
	body response.to_json
end

get '/clients/services' do
	# Pass along only the accepted MB parameters
	query = params.slice(
		"ClientID",
		"StartDate",
		"EndDate"
	)

	unless query["ClientID"]
		return [400, {"Content-Type"=>'application/json;charset=utf-8'}, 
			{error_message: "ClientID required."}.to_json]
	end

	# Make the MB API call
	client_services = ClientService.get_client_services(options=query)
	response = Array(client_services.result[:services])

	# Build the response
	content_type :json, 'charset' => 'utf-8'
	status client_services.error_code
	headers "Result count" => response.size.to_s
	body response.to_json
end

get '/clients/visits' do
	# Pass along only the accepted MB parameters
	query = params.slice(
		"ClientID",
		"StartDate",
		"EndDate"
	)

	unless query["ClientID"]
		return [400, {"Content-Type"=>'application/json;charset=utf-8'}, 
			{error_message: "Bad Request: ClientID required."}.to_json]
	end

	# Make the MB API call
	client_visits = ClientService.get_client_visits(options=query)
	response = Array(client_visits.result[:visits])

	# Build the response
	content_type :json, 'charset' => 'utf-8'
	status client_visits.error_code
	headers "Result count" => response.size.to_s
	body response.to_json
end

get '/clients/purchases' do
	# Pass along only the accepted MB parameters
	query = params.slice(
		"ClientID",
		"StartDate",
		"EndDate"
	)

	unless query["ClientID"]
		return [400, {"Content-Type"=>'application/json;charset=utf-8'}, 
			{error_message: "Bad Request: ClientID required."}.to_json]
	end

	# Make the MB API call
	client_purchases = ClientService.get_client_purchases(options=query)
	response = Array(client_purchases.result[:purchases])

	# Build the response
	content_type :json, 'charset' => 'utf-8'
	status client_purchases.error_code
	headers "Result count" => response.size.to_s
	body response.to_json
end

get '/clients/schedule' do
	# Pass along only the accepted MB parameters
	query = params.slice(
		"ClientID",
		"StartDate",
		"EndDate"
	)

	unless query["ClientID"]
		return [400, {"Content-Type"=>'application/json;charset=utf-8'}, 
			{error_message: "Bad Request: ClientID required."}.to_json]
	end

	# Make the MB API call
	client_schedule = ClientService.get_client_schedule(options=query)
	response = Array(client_schedule.result[:visits])

	# Build the response
	content_type :json, 'charset' => 'utf-8'
	status client_schedule.error_code
	headers "Result count" => response.size.to_s
	body response.to_json
end
