Rails.application.routes.draw do
  root 'home#index'
  resources :articles, only: [:index, :show]

  namespace :admin do
    resources :articles
    resources :settings
  end
end
