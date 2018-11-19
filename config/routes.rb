Rails.application.routes.draw do


  # devise_for :users
  # devise_for :users, controllers: { sessions: 'sessions' }
  # devise_for :users, defaults: { format: :json }
  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
             },
             controllers: {
               sessions: 'sessions',
               registrations: 'registrations'
             }
  devise_scope :user do
    get 'users/current', to: 'sessions#show'
  end

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
