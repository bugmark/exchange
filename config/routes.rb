Rails.application.routes.draw do
  devise_for :users
  get 'static/home'
  get 'static/help'
  get 'static/test'

  resources :repos do
    get 'sync', :on => :member
  end
  resources :repo_git_hubs      , path: "/repos"

  resources :bugs

  resources :bids
  resources :bid_cmd_creates, path: "/bids"

  resources :asks
  resources :ask_cmd_creates, path: "/asks"

  resources :offers do
    get 'cross', :on => :member
  end

  resources :contracts do
    get 'resolve', :on => :member
  end
  resources :contract_cmd_publishes  , path: "/contracts"
  resources :contract_cmd_takes      , path: "/contracts"

  resources :forecasts

  resources :users

  root "static#home"

end
