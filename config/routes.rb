Rails.application.routes.draw do
  devise_for :users
  resources :providers
  resources :partners
  resources :causes
  namespace :api, constraints: { format: 'json' } do
    namespace :v1 do
      resources :causes, only: :index
      resources :partners, only: :index
      resources :providers, only: :index
    end
  end

  root 'causes#index'
end
