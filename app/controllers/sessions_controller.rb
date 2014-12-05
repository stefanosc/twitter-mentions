get '/sign_in' do
  erb :sign_in
end

post '/sign_in' do
  redirect '/dashboard' if current_user
  if @user = User.find_by_email(params[:email]) and
  @user.authenticate(params[:password])
    session[:user_id] = @user.id
    redirect to '/'
  else
    @error = "Ooops the email and password you entered don't match"
    @email = params[:email]
    erb :sign_in
  end
end

delete '/sign_out' do
  session[:twitter_id] = nil
  redirect to '/'
end

get '/sign_in_with_twitter' do
  redirect request_token.authorize_url
end

get '/auth' do
  begin
    @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
    session.delete(:request_token)
    if user = User.find_by(twitter_id: @access_token.params[:user_id])
      session[:twitter_id] = user.twitter_id
      user.update_attributes(access_token: @access_token.token,
                             access_token_secret:@access_token.secret) unless valid_credentials?
    else
      user = User.create(screen_name: @access_token.params[:screen_name],
                  twitter_id: @access_token.params[:user_id],
                  access_token: @access_token.token,
                  access_token_secret:@access_token.secret)
      user.update_attributes(profile_image_url: user.t_account.user.profile_image_url.to_s,
                             twitter_created_at: user.t_account.user.created_at,
                             name: user.t_account.user.name)
      session[:twitter_id] = user.twitter_id
    end
    redirect '/dashboard'
  rescue => e
    flash[:"alert alert-danger"] = "There was a problem signing in, please try again"
    redirect '/sign_in'
  ensure
    session.delete(:request_token)
  end
end