Rails.application.routes.draw do
  resources :episodes
  namespace :api do
    namespace :v1 do
      resources :seasons, only: [:index, :show]

      resources :movies, only: [:index, :show]
    end
  end

end
