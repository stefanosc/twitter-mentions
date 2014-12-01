class Mention < ActiveRecord::Base
  belongs_to :user

  extend Geocoder::Model::ActiveRecord

  geocoded_by :place
  reverse_geocoded_by :latitude, :longitude, :address => :place

  attr_accessor :tweet

  def add_tweet_data(twitter_tweet)
    self.tweet = twitter_tweet
    get_fields_from_tweet
    get_location_from_tweet
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
    elsif tweet.user.location?
      self.place = tweet.user.location
      geocode
    end
  end

end
