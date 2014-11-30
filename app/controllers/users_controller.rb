get '/users/new' do
  @user = User.new
  erb :sign_in
end

post '/users' do
  @user = User.new(params[:user])
  if @user.save
    session[:user_id] = @user.id
    redirect to '/'
  else
    erb :sign_in
  end
end