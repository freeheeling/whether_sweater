Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/forecast', to: 'forecasts#index'
      get '/backgrounds', to: 'backgrounds#index'
      get '/munchies', to: 'munchies#index'

      post '/users', to: 'users#create'
      post '/sessions', to: 'sessions#create'
      post '/road_trip', to: 'road_trips#create'
    end
  end
end
