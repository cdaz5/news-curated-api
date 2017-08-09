require 'aylien_news_api'
class Api::V1::ArticlesController < ApplicationController
  include Aylien

  def fetch_articles
    user = User.find_by(email: current_user.email)
    articles = fetch_user_articles(user.interests)

    render json: articles
  end

  def save_article
    user = User.first
    saved_article = SavedArticle.new(article_params)
    saved_article.user = user

    if saved_article.save
      render json: saved_article
    else
      render json: {error: saved_article.errors.full_messages}
    end
  end

private

  def article_params
    params.permit(:title, :body, :summary, :media_img_url, :source_name, :author, :keywords, :hashtags, :facebook_shares, :linkedin_shares, :related_stories_api_call, :sentiment_polarity, :sentiment_score)
  end
end
