require File.expand_path 'spec_helper.rb', __dir__

describe 'Mindbody Wrapper Sales' do
  before do
    VCR.insert_cassette name
  end

  after do
    VCR.eject_cassette
  end

  it 'should return json to packages' do
    get '/packages'
    last_response.headers['Content-Type'].must_equal \
    'application/json;charset=utf-8'
  end

  it 'should return json to products' do
    get '/products'
    last_response.headers['Content-Type'].must_equal \
    'application/json;charset=utf-8'
  end

  it 'should return json to services' do
    get '/services'
    last_response.headers['Content-Type'].must_equal \
    'application/json;charset=utf-8'
  end
end
