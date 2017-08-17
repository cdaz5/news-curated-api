require 'aylien_news_api'
class Api::V1::ArticlesController < ApplicationController
  before_action :authorize_user!, only: [:fetch_articles, :save_article, :fetch_tweets, :fetch_sentiment, :fetch_trends]
  include Aylien
  require 'twitter'

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

  def fetch_tweets
    hashtags = params['hashtags']
    # byebug
    all_tweets = $twitter.search(hashtags, {result_type: 'recent', lang: 'en', count: 25}).map do |tweet|
      # byebug
      {
        id: tweet.id,
        name: tweet.user.name,
        screen_name: tweet.user.screen_name,
        profile_image_url: tweet.user.profile_image_url,
        text: tweet.text,
        created_at: tweet.created_at,
        favorite_count: tweet.favorite_count,
        retweet_count: tweet.retweet_count,
        media: tweet.media? ? tweet.media[0].media_url : '',
        urls: tweet.urls,
        user_mentions: tweet.user_mentions,
        hashtags: tweet.hashtags,
        symbols: tweet.symbols,
        url: tweet.url
        }
    end
    # byebug
    render json: all_tweets
  end

  def fetch_sentiment
    # byebug
    article_ids = params['articles'].map do |article|
      article['id']
    end
    sentiment_trends = fetch_sentiment_data(article_ids)

    render json: sentiment_trends
  end

  def fetch_trends
    # byebug
    article_ids = params['articles'].map do |article|
      article['id']
    end
    # user = User.find_by(email: current_user.email)
    keyword_trends = fetch_saved_article_trends(article_ids)

    render json: keyword_trends
  end

  def save_article
    user = User.find_by(email: current_user.email)
    # byebug
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
    params.permit(:aylien_id, :nextPageCursor, :article, :permalink, :title, :body, :summary, :media_img_url, :source_name, :author, :keywords, :hashtags, :facebook_shares, :linkedin_shares, :related_stories_api_call, :sentiment_polarity, :sentiment_score)
  end
end
