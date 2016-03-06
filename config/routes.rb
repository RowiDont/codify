Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :categories, only: [:index, :show, :create]
  end
end
