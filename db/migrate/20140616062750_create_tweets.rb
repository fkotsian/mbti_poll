class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :t_id_str
      t.string :created_at
      t.string :text
      t.string :retweet_count
      t.string :retweeted
      t.string :user_id_str
      t.string :user_name
      t.string :user_location
      t.string :user_statuses_count
      t.string :user_followers_count
      t.string :user_friends_count

      t.string :stored_at
    end
  end
end
