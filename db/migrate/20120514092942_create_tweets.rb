class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :user_id
      t.text :post
      t.string :from_twitter_image_url
      t.integer :from_twitter_id
      t.integer :from_twitter_user_id
      t.string :from_twitter_user
      t.string :user_image_url

      t.timestamps
    end
  end
end
