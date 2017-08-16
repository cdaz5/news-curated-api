require 'aylien_news_api'
module Aylien
# Load the gem

# Setup authorization
  AylienNewsApi.configure do |config|
    # Configure API key authorization: app_id
    config.api_key['X-AYLIEN-NewsAPI-Application-ID'] = 'dd169040'

    # Configure API key authorization: app_key
    config.api_key['X-AYLIEN-NewsAPI-Application-Key'] = 'ae7b0c0864fc3a6e0b80c34776ad59a8'
  end


  def set_opts(interests, next_page_cursor='*')
    {
      :text => "#{interests}",
      :published_at_start => 'NOW-5DAYS',
      :published_at_end => 'NOW',
      :language => ['en'],
      :sort_by => 'hotness',
      :source_locations_country => ['US'],
      :_return => ['id', 'title', 'body', 'summary', 'source', 'author', 'keywords', 'hashtags', 'social_shares_count', 'media', 'sentiment', 'links'],
      :cursor => "#{next_page_cursor}",
      :per_page => 10
    }
  end

  def set_sentiment_opts(article_ids)
    {
      :id => article_ids,
      :published_at_start => 'NOW-5DAYS',
      :published_at_end => 'NOW',
      :source_locations_country => ['US'],
    }
  end

  def set_trends_opts(article_ids)
    {
      :id => article_ids,
      :published_at_start => 'NOW-5DAYS',
      :published_at_end => 'NOW',
      :source_locations_country => ['US'],
    }
  end

  def fetch_sentiment_data(article_ids)
    opts = set_sentiment_opts(article_ids)
    api_instance = AylienNewsApi::DefaultApi.new
    begin
      #List trends
      # byebug
    api_instance.list_trends('sentiment.body.polarity', opts)
    # p result
    rescue AylienNewsApi::ApiError => e
    puts "Exception when calling DefaultApi->list_trends: #{e}"
    end
  end

  def fetch_saved_article_trends(article_ids)
    opts = set_trends_opts(article_ids)
    api_instance = AylienNewsApi::DefaultApi.new
    begin
      #List trends
      # byebug
    api_instance.list_trends('keywords', opts)
    # p result
    rescue AylienNewsApi::ApiError => e
    puts "Exception when calling DefaultApi->list_trends: #{e}"
    end
  end

  def fetch_user_articles(interests, next_page_cursor)
    opts = set_opts(interests, next_page_cursor)
      #List stories
      # byebug
    api_instance = AylienNewsApi::DefaultApi.new
    begin
        #List stories
      api_instance.list_stories(opts)
      # puts result
    rescue AylienNewsApi::ApiError => e
      puts "Exception when calling DefaultApi->list_stories: #{e}"
    end
  end

end
