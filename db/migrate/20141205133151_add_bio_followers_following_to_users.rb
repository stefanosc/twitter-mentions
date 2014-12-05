class AddBioFollowersFollowingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :description, :string
    add_column :users, :following_count, :integer
    add_column :users, :followers_count, :integer
  end
end
