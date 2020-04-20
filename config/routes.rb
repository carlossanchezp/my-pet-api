Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :seasons,     only: [:index, :show]
      resources :movies,      only: [:index, :show]
      resources :libraries,   only: [:index, :create]      
      get '/movies_seasons',  to: 'movies_seasons#index'
    end
  end
end
