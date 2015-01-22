require 'sinatra'
require 'json'
require 'mindbody-api'

configure :production do
  require 'newrelic_rpm'
end

include MindBody::Services

module MindBody
  module Models
    # Monkey patch Base class to add to_json to all Models
    class Base
      def to_json(_options = {})
        hash = {}
        instance_variables.each do |var|
          hash[var.to_s[1..-1]] = instance_variable_get var
        end
        hash.to_json
      end
    end
  end
end

module MindBody
  module Services
    # Monkey patch ClassService with extra functionality
    class ClassService
      operation :add_clients_to_classes
    end
  end
end

#
# Filters
#
before do
  # we'll always return json
  content_type :json, 'charset' => 'utf-8'
end

#
# Documentation
#
get '/' do
  # in this case, json isn't appropriate
  content_type :html

  markdown :home
end

get '/classes' do
  # Pass along only the accepted MB parameters
  query = params.slice(
    'ClassIDs',
    'StartDateTime',
    'EndDateTime',
    'LocationIDs',
    'PageSize',
    'CurrentPageIndex'
  )

  # For parameters that accept multiple ids, split values and convert to integer
  query['ClassIDs'] && query['ClassIDs'] = query['ClassIDs'].split(',')
  query['LocationIDs'] && query['LocationIDs'] = query['LocationIDs'].split(',')

  # Make the MB API call
  classes = ClassService.get_classes(query)
  response = Array(classes.result[:classes])

  # Build the response
  status classes.error_code
  headers 'Result count' => response.size.to_s
  body response.to_json
end

post '/classes/:class_id/add_client/:client_id' do
  # Pass along only the accepted MB parameters
  query = params.slice(
    'Test',
    'RequirePayment'
  )

  unless params[:class_id] &&
         params[:client_id] &&
         query['Test'] &&
         query['RequirePayment']
    return [
      400,
      { 'Content-Type' => 'application/json;charset=utf-8' },
      {
        error_message: 'ClientID, ClassIDs, Test, RequirePayment required.'
      }.to_json
    ]
  end

  # Massage parameters
  query['ClientIDs'] = { 'string' => params[:client_id] }
  query['ClassIDs'] = Array(params[:class_id])

  puts 'here'
  puts query

  # Make the MB API call
  booked_classes = ClassService.add_clients_to_classes(query)
  response = booked_classes.result[:classes]

  # Build the response
  status booked_classes.error_code
  headers 'Result count' => response.size.to_s
  body response.to_json
end

get '/sites' do
  # Pass along only the accepted MB parameters
  query = params.slice('PageSize', 'CurrentPageIndex')

  # Make the MB API call
  sites = SiteService.get_sites(query)
  response = Array(sites.result[:sites])

  # Build the response
  status sites.error_code
  headers 'Result count' => response.size.to_s
  body response.to_json
end

get '/locations' do
  # Make the MB API call
  locations = SiteService.get_locations
  response = Array(locations.result[:locations])

  # Build the response
  status locations.error_code
  headers 'Result count' => response.size.to_s
  body response.to_json
end

get '/packages' do
  # Make the MB API call
  packages = SaleService.get_packages
  response = Array(packages.result[:packages])

  # Build the response
  status packages.error_code
  headers 'Result count' => response.size.to_s
  body response.to_json
end

get '/products' do
  # Make the MB API call
  products = SaleService.get_products
  response = Array(products.result[:products])

  # Build the response
  status products.error_code
  headers 'Result count' => response.size.to_s
  body response.to_json
end

get '/services' do
  # Make the MB API call
  services = SaleService.get_services
  response = Array(services.result[:services])

  # Build the response
  status services.error_code
  headers 'Result count' => response.size.to_s
  body response.to_json
end

get '/clients' do
  # Pass along only the accepted MB parameters
  query = params.slice(
    'ClientIDs',
    'SearchText',
    'PageSize',
    'CurrentPageIndex'
  )

  # For parameters that accept multiple ids, split values and convert to integer
  query['ClientIDs'] && query['ClientIDs'] = query['ClientIDs'].split(',')

  # get_clients needs the dev account credentials
  query['UserCredentials'] = {
    'Username' => 'Siteowner',
    'Password' => 'apitest1234',
    'SiteIDs' => {
      'int' => -99
    }
  }

  # Make the MB API call
  clients = ClientService.get_clients(query)
  response = Array(clients.result[:clients])

  # Build the response
  status clients.error_code
  headers 'Result count' => response.size.to_s
  body response.to_json
end

get '/clients/services' do
  # Pass along only the accepted MB parameters
  query = params.slice(
    'ClientID',
    'StartDate',
    'EndDate'
  )

  unless query['ClientID']
    return[
      400,
      { 'Content-Type' => 'application/json;charset=utf-8' },
      { error_message: 'ClientID required.' }.to_json
    ]
  end

  # Make the MB API call
  client_services = ClientService.get_client_services(query)
  response = Array(client_services.result[:services])

  # Build the response
  status client_services.error_code
  headers 'Result count' => response.size.to_s
  body response.to_json
end

get '/clients/visits' do
  # Pass along only the accepted MB parameters
  query = params.slice(
    'ClientID',
    'StartDate',
    'EndDate'
  )

  unless query['ClientID']
    return[
      400,
      { 'Content-Type' => 'application/json;charset=utf-8' },
      { error_message: 'ClientID required.' }.to_json
    ]
  end

  # Make the MB API call
  client_visits = ClientService.get_client_visits(query)
  response = Array(client_visits.result[:visits])

  # Build the response
  status client_visits.error_code
  headers 'Result count' => response.size.to_s
  body response.to_json
end

get '/clients/purchases' do
  # Pass along only the accepted MB parameters
  query = params.slice(
    'ClientID',
    'StartDate',
    'EndDate'
  )

  unless query['ClientID']
    return[
      400,
      { 'Content-Type' => 'application/json;charset=utf-8' },
      { error_message: 'ClientID required.' }.to_json
    ]
  end

  # Make the MB API call
  client_purchases = ClientService.get_client_purchases(query)
  response = Array(client_purchases.result[:purchases])

  # Build the response
  status client_purchases.error_code
  headers 'Result count' => response.size.to_s
  body response.to_json
end

get '/clients/schedule' do
  # Pass along only the accepted MB parameters
  query = params.slice(
    'ClientID',
    'StartDate',
    'EndDate'
  )

  unless query['ClientID']
    return[
      400,
      { 'Content-Type' => 'application/json;charset=utf-8' },
      { error_message: 'ClientID required.' }.to_json
    ]
  end

  # Make the MB API call
  client_schedule = ClientService.get_client_schedule(query)
  response = Array(client_schedule.result[:visits])

  # Build the response
  status client_schedule.error_code
  headers 'Result count' => response.size.to_s
  body response.to_json
end
