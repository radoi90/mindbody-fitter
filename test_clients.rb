describe "Mindbody Wrapper Clients" do
	
	it "should return json to clients" do
		VCR.insert_cassette 'mindbody-clients'

		get '/clients'
		last_response.headers['Content-Type'].must_equal 'application/json;charset=utf-8'

		VCR.eject_cassette
	end

end