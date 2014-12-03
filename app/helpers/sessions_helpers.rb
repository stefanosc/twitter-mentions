helpers do

  def current_user
    if session[:user_id]
      @user ||= User.find(session[:user_id])
    end
  end

  def require_user
    unless current_user
      flash[:"alert alert-danger"] = "The page you tried to access requires sign in"
      redirect '/sign_in'
    end
  end

  def oauth_consumer
    raise RuntimeError, "You must set CONSUMER_KEY and CONSUMER_SECRET in your server environment." unless ENV['CONSUMER_KEY'] && ENV['CONSUMER_SECRET']
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
