Rails.application.routes.draw do
  devise_for :users
  get 'static/home'

  get 'static/help'

  resources :contracts
  resources :wallets
  resources :users
  resources :issues
  resources :repos

  root "static#home"

end
