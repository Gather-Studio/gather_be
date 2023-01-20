Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :sessions, only: [:create]
      resources :glazes
      resources :users do 
        resources :items, controller: :user_items
      end
    end
  end
end
