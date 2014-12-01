class User < ActiveRecord::Base

  include BCrypt

  has_many :mentions

  validates_uniqueness_of :email
  validates_presence_of :name, :email
  validates :password, length: { minimum: 6 }

  def t_account
    @t_account ||= Twitter::REST::Client.new do |config|
      config.consumer_key    = ENV["T_CONSUMER_KEY"]
      config.consumer_secret = ENV["T_CONSUMER_SECRET"]
      config.access_token = self.t_access_token
      config.access_token_secret = self.t_access_token_secret
    end
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def authenticate pass
    self.password == pass
  end

  def fetch_new_twitter_mentions
    if self.mentions.any?
      new_mentions = self.t_account.mentions(since_id: self.mentions.last.twitter_tweet_id)
    else
      new_mentions = self.t_account.mentions
    end
    if new_mentions.any?
      new_mentions.reverse_each do |tweet|
        mention = self.mentions.build
        mention.add_tweet_data(tweet)
        mention.save
      end
    end
  end

end
