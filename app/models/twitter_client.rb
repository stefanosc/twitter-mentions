class TwitterClient

  def initialize

  end

client = Twitter::REST::Client.new do |config|
  config.consumer_key    = ENV["T_CONSUMER_KEY"]
  config.consumer_secret = ENV["T_CONSUMER_SECRET"]
  config.bearer_token    = ENV["T_BEARER"]
end

end