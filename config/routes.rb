Rails.application.routes.draw do
  root 'home#index'

  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :users
      resources :lists
      resources :items
      resources :sessions, only: [:create, :destroy] do
        collection do
          get :current, to: 'sessions#current'
        end
      end

      resources :urls, only: :index

      match '/*path', to: 'api#handle_options_request', via: [:options]
    end
  end

  # resources :users
  resources :lists

  devise_for :users do
    resources :users
  end

end
