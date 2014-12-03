class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :screen_name
      t.string :email
      t.string :password_hash
      t.string :access_token
      t.string :access_token_secret
      t.datetime :twitter_created_at
      t.integer :twitter_id, limit: 8
      t.string :profile_image_url
      t.timestamps
    end
  end
end
