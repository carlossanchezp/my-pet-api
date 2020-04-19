Rails.application.routes.draw do
  get 'movies_seasons/index'
  resources :episodes
  namespace :api do
    namespace :v1 do
      resources :seasons, only: [:index, :show]
      resources :movies, only: [:index, :show]
      get '/movies_seasons', to: 'movies_seasons#index'
    end
  end

end
