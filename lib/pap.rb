require 'twitter'
  require 'dotenv'
    require 'pry'

  Dotenv.load

def logtostream
	client = Twitter::Streaming::Client.new do |config|
	  config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
	  config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
	  config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
	  config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
	end
	return client 
end


def login_twitter
	client = Twitter::REST::Client.new do |config|
	  config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
	  config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
	  config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
	  config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
	end
	return client 
end
	# client = login_twitter

	# topics = ["bonjour_monde"]
	# client.filter(track: topics.join(",")) do |object|
	#   puts object.text if object.is_a?(Twitter::Tweet)
	#   puts tweet.user.screen_name if object.is_a?(Twitter::Tweet)
	# end



def stream
 topics = ["#bonjour_monde"]    #saisie de la donnee recherchee
 logtostream.filter(track: topics.join(",")) do |tweet|
 #utilisation du logstreaming pour filtrer les resultat contenant la track: topics
   puts "#{tweet.user.screen_name}: #{tweet.text}"
   if tweet.is_a?(Twitter::Tweet)
        puts "--------------------"
     login_twitter.favorite(tweet.id)
     login_twitter.follow(tweet.user)
   end
 end
end

stream