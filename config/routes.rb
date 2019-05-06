Rails.application.routes.draw do
  root 'home#index'
  get '/articles', to: 'articles#index', as: :articles
  get '/articles/:id/:slug', to: 'articles#show', as: :article

  namespace :admin do
    resources :articles
    resources :settings
  end
end
