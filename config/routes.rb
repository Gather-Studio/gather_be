Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :users do 
        resources :items, controller: :user_items
      end
      resources :sessions, only: [:create]
    end
  end
end
