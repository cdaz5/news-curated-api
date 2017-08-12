class SavedArticleSerializer < ActiveModel::Serializer
  belongs_to :user
  attributes :id, :title, :body, :summary, :media_img_url, :source_name, :author, :keywords, :hashtags, :facebook_shares, :linkedin_shares, :related_stories_api_call, :sentiment_polarity, :sentiment_score, :permalink
end
