Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :categories, only: [:index, :show, :create]
    resources :resources, only: [:index, :show, :create]
    resources :users, only: :create
    resource :user, only: :show
  end
end
