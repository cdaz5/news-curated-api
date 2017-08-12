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


  def set_opts(interests)
    {
      :text => "#{interests}",
      :published_at_start => 'NOW-5DAYS',
      :published_at_end => 'NOW',
      :language => ['en'],
      :per_page => 10,
      :sort_by => 'hotness',
      :source_locations_country => ['US'],
      :_return => ['title', 'body', 'summary', 'source', 'author', 'keywords', 'hashtags', 'social_shares_count', 'media', 'sentiment', 'links']
    }
  end

  def fetch_user_articles(interests)
    opts = set_opts(interests)
      #List stories
    api_instance = AylienNewsApi::DefaultApi.new
    begin
        #List stories
      api_instance.list_stories(opts)
      # byebug
      # puts result
    rescue AylienNewsApi::ApiError => e
      puts "Exception when calling DefaultApi->list_stories: #{e}"
    end
  end

end
