require 'sinatra'
require 'redcarpet'
require 'pygments'
require 'json'
require './lib/mind_body_integration'

require_relative 'helpers/markdown'

configure :production do
  require 'newrelic_rpm'
end

#
# Filters
#
before do
  # we'll always return json
  content_type :json, 'charset' => 'utf-8'
end

after do
  # build response if returning a MINDBODY result
  if request.path != '/'
    halt 400 unless @result

    # Build the response
    status @result.error_code
    headers 'Result-Count' => @result.result_count.to_s
    body @result.result.to_json
  end
end

#
# Routes
#

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
  @result = ClassService.get_classes(query)
end

post '/classes/:class_id/add_client/:client_id' do
  # Pass along only the accepted MB parameters
  query = params.slice('Test', 'RequirePayment')

  unless query['Test'] && query['RequirePayment']
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

  # Make the MB API call
  @result = ClassService.add_clients_to_classes(query)
end

#
# Site Service routes
#

%w(sites locations).each do |path|
  get('/' + path) do
    # Make the MB API call
    @result = SiteService.send('get_' + path)
  end
end

#
# Sale Service routes
#

%w(packages products services).each do |path|
  get('/' + path) do
    # Make the MB API call
    @result = SaleService.send('get_' + path)
  end
end

#
# Client Service routes
#

get '/clients/:client_id' do
  # Make the MB API call
  @result = ClientService.get_clients(
    'ClientIDs' => { 'string' => params[:client_id] }
  )
end

%w(services visits purchases schedule).each do |path|
  get('/clients/:client_id/' + path) do
    # Pass along only the accepted MB parameters
    query = params.slice('StartDate', 'EndDate')

    # Make the MB API call
    @result = ClientService.send('get_client_' + path,
                                 { 'string' => params[:client_id] },
                                 query)
  end
end

#
# Error Handling
#
not_found do
  { message: 'Route not found. Check your syntax.' }.to_json
end
