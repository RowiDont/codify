Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :categories, only: [:index, :show, :create]
    resources :resources, only: [:index, :show, :create]
    resources :users, only: [:create, :new]
    resource :user, only: :show
    resources :project_shares, only: [:create, :destroy]
  end

  root "static_pages#root"
end
