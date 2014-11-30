class User < ActiveRecord::Base

  include BCrypt

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
end
