Rails.application.routes.draw do
  root to: 'ping#ping'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post 'signin', to: 'users#signin', as: :signin
      post 'signup', to: 'users#create', as: :signup
      post 'auth', to: 'users#auth', as: :auth
      get 'profile', to: 'users#profile', as: :profile
      resources :users, only: [:create]
    end
  end
end
