Rails.application.routes.draw do

  post 'sessions', controller: :sessions, action: :create
  delete 'sessions', controller: :sessions, action: :destroy
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

      resources :places, only: [:show]

      resources :locations do
        resources :trips
        resources :reviews
      end

      resources :trips do 
        resources :companions

        put 'created_mail', to: 'trips#created_mail'
        put 'completed_mail', to: 'trips#completed_mail'
        put 'cancelled_mail', to: 'trips#cancelled_mail'
      end

      resources :companions, only: [:show, :create, :destroy]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
