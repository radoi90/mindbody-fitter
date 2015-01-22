require File.expand_path 'spec_helper.rb', __dir__

describe 'Mindbody Wrapper Clients' do
  before do
    VCR.insert_cassette name
  end

  after do
    VCR.eject_cassette
  end

  it 'should return json to clients' do
    get '/clients'
    last_response.headers['Content-Type'].must_equal \
    'application/json;charset=utf-8'
  end

  it 'should return json to client services' do
    get '/clients/services'
    last_response.headers['Content-Type'].must_equal \
    'application/json;charset=utf-8'
  end

  it 'should return json to client visits' do
    get '/clients/visits'
    last_response.headers['Content-Type'].must_equal \
    'application/json;charset=utf-8'
  end

  it 'should return json to client purchases' do
    get '/clients/purchases'
    last_response.headers['Content-Type'].must_equal \
    'application/json;charset=utf-8'
  end

  it 'should return json to clients schedule' do
    get '/clients/schedule'
    last_response.headers['Content-Type'].must_equal \
    'application/json;charset=utf-8'
  end
end
