Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :seasons, only: [:index, :show]
      resources :movies, only: [:index, :show]
      resources :purchases , only: [:create]
      resources :libraries, only: [:index]      
      get '/movies_seasons', to: 'movies_seasons#index'
    end
  end

end
