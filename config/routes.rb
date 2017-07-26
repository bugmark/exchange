Rails.application.routes.draw do
  devise_for :users
  get 'static/home'

  get 'static/help'

  resources :contracts
  resource  :contract_forecasts , path: "/contracts"
  resources :contract_pubs      , path: "/contracts"
  resources :contract_takes     , path: "/contracts"
  resources :wallets
  resources :users
  resources :bugs
  resources :repos
  resources :bings
  resources :bongs

  root "static#home"

end
