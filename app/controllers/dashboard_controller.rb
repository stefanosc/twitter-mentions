get '/dashboard' do
  require_user
  current_user.fetch_new_twitter_mentions
  @tweets = current_user.mentions.includes(:author).reverse_order.limit(10)
  @coords = current_user.mentions.includes(:author).where("latitude IS NOT NULL").pluck(:latitude, :longitude, :profile_image_url)
  @top_mentioners = current_user.mentions.limit(10).group(:screen_name).count
  if @top_mentioners.any?
    @max_count = @top_mentioners.max_by { |key, val| val }.last
  else
    @max_count = nil
  end
  erb :"dashboard/show"
end