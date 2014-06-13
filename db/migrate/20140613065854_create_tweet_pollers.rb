class CreateTweetPollers < ActiveRecord::Migration
  def change
    create_table :tweet_pollers do |t|

      t.timestamps
    end
  end
end
