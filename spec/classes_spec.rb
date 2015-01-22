require File.expand_path 'spec_helper.rb', __dir__

describe 'Mindbody Wrapper Classes' do
  before do
    VCR.insert_cassette name
  end

  after do
    VCR.eject_cassette
  end

  it 'should return json to classes' do
    get '/classes'
    last_response.headers['Content-Type'].must_equal \
    'application/json;charset=utf-8'
  end

  it 'should return some classes' do
    get '/classes'
    JSON.parse(last_response.body).wont_be_nil
  end

  it 'should get 1 class when PageSize is 1' do
    get '/classes?PageSize=1'
    last_response.headers['Result count'].to_i.must_equal 1
  end

  it 'should get classes within a date interval' do
    jan_22 = DateTime.new(2015, 01, 22)
    jan_23 = DateTime.new(2015, 01, 23)

    # format the dates so that the MB API accepts them, ex. 2015-01-23T00:00:00
    jan_22s = jan_22.strftime '%Y-%m-%dT%H:%M:%S'
    jan_23s = jan_23.strftime '%Y-%m-%dT%H:%M:%S'

    get('/classes?StartDateTime=' + jan_22s + '&EndDateTime=' + jan_23s)

    first_class = JSON.parse(last_response.body).first
    Date.strptime(first_class['start_date_time']).must_be :>=, jan_22
    Date.strptime(first_class['end_date_time']).must_be :<=, jan_23
  end

  it 'should return json to /classes/add_client' do
    post '/classes/1/add_client/1'
    last_response.headers['Content-Type'].must_equal \
    'application/json;charset=utf-8'
  end

  it "should return a message if booking can't be made" do
    post '/classes/1/add_client/1?',
         Test: true, RequirePayment: false

    reply_body = JSON.parse(last_response.body)
    reply_body['clients']['messages'].wont_be_nil
  end
end
