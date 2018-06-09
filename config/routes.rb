Rails.application.routes.draw do
  resources :transactions
  resources :donations
  devise_for :users
  resources :providers
  resources :partners
  resources :causes
  resources :projects
  namespace :api, constraints: { format: 'json' } do
    namespace :v1 do
      resources :causes, only: :index
      resources :projects, only: :index
      resources :partners, only: :index
      resources :providers, only: :index
      resources :users, only: :show

      namespace :backdoor do
        post '/record', to: 'partners#record'
      end
    end
  end

  root 'causes#index'
end
