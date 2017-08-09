Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # post '/login', to: 'auth#create'
      # get '/me', tp: 'auth#show'
      post '/signup', to: 'users#create'
      post '/users/edit', to: 'users#edit'
      # get '/articles', to: 'articles#index'
      get '/articles', to: 'articles#fetch_articles'
      post '/saved_articles', to: 'articles#save_article'
    end
  end
end
