Rails.application.routes.draw do
  devise_for :users
  get 'static/home'

  get 'static/help'

  resources :contracts
  resources :contract_rewards  , path: "/contracts"
  resources :contract_forecasts, path: "/contracts"
  resources :contract_forms    , path: "/contracts"
  resources :wallets
  resources :users
  resources :bugs
  resources :repos
  resources :bings
  resources :bongs

  root "static#home"

end
