Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :articles, only: [:index] do
    resources :comments, only: [:create]
  end
  get '/articles/:id/:slug', to: 'articles#show', as: 'article'


  get '/admin', to: 'admin#index', as: :admin
  namespace :admin do
    resources :articles
    resources :settings
    resources :images, only: [:destroy]
  end
end
