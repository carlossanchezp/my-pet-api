Rails.application.routes.draw do
  resources :episodes
  namespace :api do
    namespace :v1 do
      resources :seasons

      resources :movies, only: [:index, :show]
    end
  end

end
