describe "Mindbody Wrapper Clients" do
	
	it "should return json to clients" do
		VCR.insert_cassette 'mindbody-clients'

		get '/clients'
		last_response.headers['Content-Type'].must_equal 'application/json;charset=utf-8'

		VCR.eject_cassette
	end

	it "should return json to client services" do
		VCR.insert_cassette 'mindbody-clients-services'

		get '/clients/services'
		last_response.headers['Content-Type'].must_equal 'application/json;charset=utf-8'

		VCR.eject_cassette
	end

	it "should return json to client visits" do
		VCR.insert_cassette 'mindbody-clients-visits'

		get '/clients/visits'
		last_response.headers['Content-Type'].must_equal 'application/json;charset=utf-8'

		VCR.eject_cassette
	end

	it "should return json to client purchases" do
		VCR.insert_cassette 'mindbody-clients-purchases'

		get '/clients/purchases'
		last_response.headers['Content-Type'].must_equal 'application/json;charset=utf-8'

		VCR.eject_cassette
	end

	it "should return json to clients schedule" do
		VCR.insert_cassette 'mindbody-clients-schedule'

		get '/clients/schedule'
		last_response.headers['Content-Type'].must_equal 'application/json;charset=utf-8'

		VCR.eject_cassette
	end
end