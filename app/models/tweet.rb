class Tweet < ActiveRecord::Base
  attr_accessible :from_twitter_id, :from_twitter_image_url, :from_twitter_user, :from_twitter_user_id, :post, :user_id, :user_image_url
end
