Rails.application.routes.draw do
  devise_for :users
  get 'static/home'

  get 'static/help'

  resources :contracts
  resources :contract_rewards  , path: "/contracts"
  resources :contract_forecasts, path: "/contracts"
  resources :wallets
  resources :users
  resources :bugs
  resources :repos

  root "static#home"

end
