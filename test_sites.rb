describe "Mindbody Wrapper Sites" do

	it "should return json to sites" do
		VCR.insert_cassette 'mindbody-sites'

		get '/sites'
		last_response.headers['Content-Type'].must_equal 'application/json;charset=utf-8'	

		VCR.eject_cassette
	end

	it "should return json to locations" do
		VCR.insert_cassette 'mindbody-locations'

		get '/locations'
		last_response.headers['Content-Type'].must_equal 'application/json;charset=utf-8'

		VCR.eject_cassette
	end
	
end