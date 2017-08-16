module Twitter

  Twitter::REST::Client.new do |config|
    config.consumer_key    = "xvz1evFS4wEEPTGEFPHBog"
    config.consumer_secret = "L8qq9PZyRg6ieKGEKhZolGC0vJWLw8iEJ88DRdyOg"
    config.bearer_token    = "AAAAAAAAAAAAAAAAAAAAAGK61wAAAAAAS1zMrr5hvao%2BChZxaI24t4v63Z4%3D2AHwce8HEZwwjsqUXdX3hRx6oNRBThRMAHp00UqzBPG0mviWLB"
  end

  def get_tweets(user)
  client = Twitter::REST::Client.new
  user = client.user(user)
  byebug

  end

end
