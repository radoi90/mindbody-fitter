require File.expand_path 'spec_helper.rb', __dir__

describe 'Mindbody Wrapper Sites' do
  before do
    VCR.insert_cassette name
  end

  after do
    VCR.eject_cassette
  end

  it 'should return json to sites' do
    get '/sites'
    last_response.headers['Content-Type'].must_equal \
    'application/json;charset=utf-8'
  end

  it 'should return json to locations' do
    get '/locations'
    last_response.headers['Content-Type'].must_equal \
    'application/json;charset=utf-8'
  end
end
