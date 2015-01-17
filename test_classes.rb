describe "Mindbody Wrapper Classes" do

	it "should return json to classes" do
		VCR.insert_cassette 'mindbody-classes'

		get '/classes'
		last_response.headers['Content-Type'].must_equal 'application/json;charset=utf-8'

		VCR.eject_cassette
	end

	it "should return some classes" do
		VCR.insert_cassette 'mindbody-classes'

		get '/classes'
		JSON.parse(last_response.body).wont_be_nil

		VCR.eject_cassette
	end

	it "should get 1 class when PageSize is 1" do
		VCR.insert_cassette 'mindbody-classes-pagesize-1'

		get '/classes?PageSize=1'
		last_response.headers['Result count'].to_i.must_equal 1

		VCR.eject_cassette
	end

	it "should get classes within a date interval" do
		VCR.insert_cassette 'mindbody-classes-jan-22-23'

		jan_22 = DateTime.new(2015,01,22)
		jan_23 = DateTime.new(2015,01,23)

		# format the dates so that the MB API accepts them, ex. 2015-01-23T00:00:00
		jan_22s = jan_22.strftime '%Y-%m-%dT%H:%M:%S'
		jan_23s = jan_23.strftime '%Y-%m-%dT%H:%M:%S'

		get ('/classes?StartDateTime=' + jan_22s + '&EndDateTime=' + jan_23s)
		
		first_class = JSON.parse(last_response.body).first
		Date.strptime(first_class["start_date_time"]).must_be :>=, jan_22
		Date.strptime(first_class["end_date_time"]).must_be :<=, jan_23

		VCR.eject_cassette
	end
end