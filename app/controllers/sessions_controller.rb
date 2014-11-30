get '/sign_in' do
  erb :sign_in
end

post '/sign_in' do
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
  session[:user_id] = nil
  redirect to '/'
end

