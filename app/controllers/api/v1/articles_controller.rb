require 'aylien_news_api'
class Api::V1::ArticlesController < ApplicationController
  before_action :authorize_user!, only: [:fetch_articles, :save_article]
  include Aylien

  def fetch_articles
    # byebug
    if params['nextPageCursor'] == ""
      params['nextPageCursor'] = "*"
    end
    # byebug
    user = User.find_by(email: current_user.email)
    articles = fetch_user_articles(user.interests, params['nextPageCursor'])
    # byebug
    render json: articles
  end

  def save_article
    user = User.find_by(email: current_user.email)
    saved_article = SavedArticle.new(article_params)
    saved_article.user_id = user.id

    if saved_article.save
      render json: saved_article
    else
      render json: {error: saved_article.errors.full_messages}
    end
  end

private

  def article_params
    params.permit(:nextPageCursor, :article, :permalink, :title, :body, :summary, :media_img_url, :source_name, :author, :keywords, :hashtags, :facebook_shares, :linkedin_shares, :related_stories_api_call, :sentiment_polarity, :sentiment_score)
  end
end
