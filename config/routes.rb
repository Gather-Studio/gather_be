Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :sessions, only: [:create]
      resources :glazes
      resources :items, only: [:index]
      resources :item_glazes, only: [:create, :update, :destroy]
      resources :users do 
        resources :items, controller: :user_items
      end
    end
  end
end
