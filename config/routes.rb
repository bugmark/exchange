Rails.application.routes.draw do
  devise_for :users
  get 'static/home'

  get 'static/help'

  resources :contracts do
    get 'resolve', :on => :member
  end
  resources :contract_cmd_publishes  , path: "/contracts"
  resources :contract_cmd_takes      , path: "/contracts"

  resources :users

  resources :bugs

  resources :offers

  resources :repos do
    get 'sync', :on => :member
  end
  resources :repo_git_hubs      , path: "/repos"

  root "static#home"

end
