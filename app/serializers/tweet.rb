class TweetSerializer < ActiveModel::Serializer
  attributes :id, :user, :name, :screen_name, :profile_image_url, :text, :created_at, :favorite_count, :retweet_count, :entities, :media, :urls, :user_mentions, :hashtags, :symbols
end
