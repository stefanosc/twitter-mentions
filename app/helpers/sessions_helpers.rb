helpers do

  def current_user
    if session[:twitter_id]
      @user ||= User.find_by(twitter_id: session[:twitter_id])
    end
  end

  def require_user
    if current_user
      verify_credentials
    else
      flash[:"alert alert-danger"] = "The page you tried to access requires sign in"
      redirect '/sign_in'
    end
  end

  def valid_credentials?
    current_user.t_account.verify_credentials
  rescue Twitter::Error::Unauthorized => e
    false
  end

  def verify_credentials
    current_user.t_account.verify_credentials
  rescue Twitter::Error::Unauthorized => e
    flash[:"alert alert-info"] = "please click on the \"Login with Twitter\" button"
    redirect '/sign_in'
  end

  def oauth_consumer
    @consumer ||= OAuth::Consumer.new(
      ENV['CONSUMER_KEY'],
      ENV['CONSUMER_SECRET'],
      :site => "https://api.twitter.com"
    )
  end

  def request_token
    if not session[:request_token]
      session[:request_token] = oauth_consumer.get_request_token(
        :oauth_callback => ENV["OAUTH_CALLBACK"]
      )
    end
    session[:request_token]
  end



end
