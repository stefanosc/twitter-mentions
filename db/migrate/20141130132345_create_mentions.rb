class CreateMentions < ActiveRecord::Migration
  def change
    create_table :mentions do |t|
      t.integer :twitter_tweet_id, :twitter_place_id, :limit => 8
      t.string :screen_name, :place
      t.float  :latitude, :longitude
      t.references :user
      t.references :author
      t.datetime :tweet_created_at
      t.timestamps
    end
  end
end
