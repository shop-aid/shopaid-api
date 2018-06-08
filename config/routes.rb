Rails.application.routes.draw do
  resources :partners
  resources :causes
  namespace :api, constraints: { format: 'json' } do
    namespace :v1 do
      resources :causes, only: :index
    end
  end

  root 'causes#index'
end
