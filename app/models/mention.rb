class Mention < ActiveRecord::Base
  belongs_to :user
  belongs_to :author, class_name: 'User'

  extend Geocoder::Model::ActiveRecord

  geocoded_by :place
  reverse_geocoded_by :latitude, :longitude, :address => :place

  attr_accessor :tweet

  def add_tweet_data(twitter_tweet)
    self.tweet = twitter_tweet
    get_fields_from_tweet
    get_location_from_tweet
    find_or_create_author_from_tweet
  end

  def get_fields_from_tweet
    self.update_attributes(twitter_tweet_id: tweet.id,
                           screen_name: tweet.user.screen_name,
                           tweet_created_at: tweet.created_at)
  end

  def get_location_from_tweet
    if tweet.geo?
      self.update_attributes(latitude:         tweet.geo.lat,
                             longitude:        tweet.geo.long,
                             place:            tweet.place.full_name,
                             twitter_place_id: tweet.place.id)
    elsif tweet.place?
      if tweet.place.full_name?
        self.place = tweet.place.full_name
      else
        self.place = tweet.place.name
      end
      self.twitter_place_id = tweet.place.id
      geocode
    elsif tweet.user.location? and Geocoder.search(tweet.user.location).any?
      self.place = tweet.user.location
      geocode
    end
  end

  def find_or_create_author_from_tweet
    if author = User.find_by(twitter_id: tweet.user.id)
      self.author = author
    else
      user = TClient.user(tweet.user.id)
      self.create_author(name: user.name,
                        screen_name: user.screen_name,
                        twitter_created_at: user.created_at,
                        twitter_id: user.id,
                        profile_image_url: user.profile_image_uri_https.to_s,
                        description: user.description,
                        followers_count: user.followers_count,
                        following_count: user.friends_count)
    end
  end

end
