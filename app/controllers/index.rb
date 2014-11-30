get '/' do
  @user = User.new
  if current_user
    redirect '/dashboard'
  else
    erb :index
  end
end

