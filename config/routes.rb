Rails.application.routes.draw do
  resources :sessions
  post 'refresh', controller: :refresh, action: :create

  namespace :api do
    namespace :v1 do
      resources :users do
        resources :contacts
        resources :reviews
        resources :trips
      end

      resources :locations do
        resources :trips
        resources :reviews
      end

    end
    namespace :v2 do
      resources :users do
        resources :contacts
        resources :reviews
        resources :trips
      end

      resources :locations do
        resources :trips
        resources :reviews
      end

    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
