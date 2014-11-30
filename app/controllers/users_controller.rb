get '/sign_up' do
  @user = User.new
  erb :sign_up
end

post '/sign_up' do
  @user = User.new(params[:user])
  if @user.save
    session[:user_id] = @user.id
    redirect to '/'
  else
    erb :sign_up
  end
end

get '/users/:id' do

end

get 'users/:id/edit' do

end

put 'users/:id' do

end