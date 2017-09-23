Rails.application.routes.draw do
  devise_for :users
  get 'static/home'
  get 'static/help'
  get 'static/test'

  namespace :core do

    resource :home

    resources :repos do
      get 'sync', :on => :member
    end
    resources :repo_git_hubs        , path: "/core/repos"

    resources :bugs

    resources :bids
    resources :bid_cmd_creates      , path: "/core/bids"

    resources :asks
    resources :ask_cmd_creates      , path: "/core/asks"

    resources :offers do
      get 'cross', :on => :member
    end

    resources :rewards do
      get 'resolve', :on => :member
    end
    resources :reward_cmd_publishes , path: "/core/rewards"
    resources :reward_cmd_takes     , path: "/core/rewards"

    resources :forecasts

    resources :users

  end

  namespace :docfix do
    resource :home
  end

  root "static#home"

end
