Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      get '/forecast', to: 'weather#forecast'
      get '/backgrounds', to: 'cityimage#background'
      get '/book-search', to: 'books#search'
      post '/road_trip', to: 'roadtrip#index'

      post '/users', to: 'users#create'
      post '/sessions', to: 'users/sessions#create'
    end
  end
end
