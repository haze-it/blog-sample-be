Rails.application.routes.draw do
  root to: 'ping#ping'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post 'signin', to: 'users#signin', as: :signin
      post 'auth', to: 'users#auth', as: :auth
      resources :users, only: [:show, :create]
    end
  end
end
