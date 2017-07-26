Rails.application.routes.draw do
  devise_for :users
  get 'static/home'

  get 'static/help'

  resources :contracts
  resources :contract_create_forms, path: "/contracts"
  resources :wallets
  resources :users
  resources :bugs
  resources :repos
  resources :bings
  resources :bongs

  root "static#home"

end
