module Twitter

  Twitter::REST::Client.new do |config|
    config.consumer_key    = ""
    config.consumer_secret = ""
    config.bearer_token    = ""
  end

  def get_tweets(user)
  client = Twitter::REST::Client.new
  user = client.user(user)
  byebug

  end

end
