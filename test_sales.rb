describe "Mindbody Wrapper Sales" do
	
	it "should return json to packages" do
		VCR.insert_cassette 'mindbody-packages'

		get '/packages'
		last_response.headers['Content-Type'].must_equal 'application/json;charset=utf-8'

		VCR.eject_cassette
	end

	it "should return json to products" do
		VCR.insert_cassette 'mindbody-products'

		get '/products'
		last_response.headers['Content-Type'].must_equal 'application/json;charset=utf-8'

		VCR.eject_cassette
	end

	it "should return json to services" do
		VCR.insert_cassette 'mindbody-services'

		get '/services'
		last_response.headers['Content-Type'].must_equal 'application/json;charset=utf-8'

		VCR.eject_cassette
	end

end