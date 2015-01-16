$:.unshift('mindbody-api/lib')
require 'sinatra'
require 'json'
require 'mindbody-api'

configure :production do
  require 'newrelic_rpm'
end

include MindBody::Services

class MindBody::Models::Base
	def to_json(options = {})
        hash = {}
        self.instance_variables.each do |var|
            hash[var.to_s[1..-1]] = self.instance_variable_get var
        end
        hash.to_json
	end
end

get '/' do
	stevie_j_quotes = [
		"Don’t let the noise of others’ opinions drown out your own inner voice.",
		"Have the courage to follow your heart and intuition. They somehow already know what you truly want to become. Everything else is secondary.",
		"Sometimes life's going to hit you in the head with a brick. Don't lose faith. I'm convinced that the only thing that kept me going was that I loved what I did.",
		"Why join the navy if you can be a pirate?",
		"Taking LSD was a profound experience, one of the most important things in my life. LSD shows you that there’s﻿ another side to the coin, and you can’t remember it when it wears off, but you know it. It reinforced my sense of what was important—creating great things instead of making money, putting things back into the stream of history and of human consciousness as much as I could.",
		"The heaviness of being successful was replaced by the lightness of being a beginner again.",
		"The only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle.",
		"Your time is limited, so don't waste it living someone else's life. Don't be trapped by dogma - which is living with the results of other people's thinking. Don't let the noise of others' opinions drown out your own inner voice. And most important, have the courage to follow your heart and intuition.",
		"For the past 33 years, I have looked in the mirror every morning and asked myself: 'If today were the last day of my life, would I want to do what I am about to do today?' And whenever the answer has been 'No' for too many days in a row, I know I need to change something.",
		"Everyone here has the sense that right now is one of those moments when we are influencing the future.",
		"Innovation distinguishes between a leader and a follower.",
		"My favorite things in life don't cost any money. It's really clear that the most precious resource we all have is time.",
		"Be a yardstick of quality. Some people aren't used to an environment where excellence is expected.",
		"Design is not just what it looks like and feels like. Design is how it works.",
		"Sometimes when you innovate, you make mistakes. It is best to admit them quickly, and get on with improving your other innovations.",
		"Stay hungry, stay foolish.",
		"Computers themselves, and software yet to be developed, will revolutionize the way we learn.",
		"Design is a funny word. Some people think design means how it looks. But of course, if you dig deeper, it's really how it works."
	]

	stevie_j_quotes.sample + " - Steve Jobs"
end

get '/classes' do
	# Pass along only the accepted MB parameters
	query = params.slice(
		"ClassIDs",
		"StartDateTime",
		"EndDateTime",
		"LocationIDs",
		"PageSize",
		"CurrentPageIndex"
	)

	# Make the MB API call
	classes = ClassService.get_classes(options=query)

	# Build the response
	content_type :json, 'charset' => 'utf-8'
	status classes.error_code
	headers "Result count" => response.size.to_s
	body response.to_json
end