Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/login', to: 'auth#create'
      get '/me', to: 'auth#show'
      post '/signup', to: 'users#create'
      post '/users/edit', to: 'users#edit'
      get '/user/articles', to: 'users#user_saved_articles'
      post '/articles', to: 'articles#fetch_articles'
      post '/saved_articles', to: 'articles#save_article'
      delete '/delete/saved_article', to: 'users#delete_user_saved_article'
      post '/trends', to: 'articles#fetch_trends'
      post '/sentiment', to: 'articles#fetch_sentiment'
      post '/tweets', to: 'articles#fetch_tweets'
    end
  end
end
