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

end
