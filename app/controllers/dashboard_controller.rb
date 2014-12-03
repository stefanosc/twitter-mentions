get '/dashboard' do
  require_user
  @tweets = current_user.mentions.reverse_order.limit(10)
  @coords = current_user.mentions.where("latitude IS NOT NULL").pluck(:latitude, :longitude)
  @top_mentioners = current_user.mentions.limit(5).group(:screen_name).count
  if @top_mentioners.any?
    @max_count = @top_mentioners.max_by { |key, val| val }.last
  else
    @max_count = nil
  end
  erb :"dashboard/show"
end