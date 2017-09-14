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

  resources :rewards do
    get 'resolve', :on => :member
  end
  resources :reward_cmd_publishes , path: "/rewards"
  resources :reward_cmd_takes     , path: "/rewards"

  resources :forecasts

  resources :users

  root "static#home"

end
