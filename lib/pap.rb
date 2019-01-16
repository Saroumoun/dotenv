require 'twitter'
  require 'dotenv'
    require 'pry'

  Dotenv.load

def log_to_stream
	stream = Twitter::Streaming::Client.new do |config|
	  config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
	  config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
	  config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
	  config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
	end
	return stream
end


def log_to_twitter
	client = Twitter::REST::Client.new do |config|
	  config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
	  config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
	  config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
	  config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
	end
	return client 
end



def active_bot
	client = log_to_twitter
	stream = log_to_stream

 	topics = ["#bonjour_monde"]

 	stream.filter(track: topics.join(",")) do |tweet|
	 	if tweet.is_a?(Twitter::Tweet)
		 	puts "-" * 10
		 	puts "#{tweet.user.screen_name}: #{tweet.text}" 
		    puts "-" * 5
		    
		    client.favorite(tweet.id)
		    puts "Vous avez aimé le tweet :#{tweet.text}"
		    puts "-" * 5
		    client.follow(tweet.user)
		    puts "vous suivez désormais : #{tweet.user.screen_name}"
   		end
 	end
end

active_bot