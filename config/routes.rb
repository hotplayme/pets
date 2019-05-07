Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :articles, only: [:index, :show] do
    get '/articles', to: 'articles#index', as: :articles
    get '/articles/:id/:slug', to: 'articles#show', as: :article
    resources :comments, only: [:create]
  end


  get '/admin', to: 'admin#index', as: :admin
  namespace :admin do
    resources :articles
    resources :settings
  end
end
