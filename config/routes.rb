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
    resources :asks
    resources :offers do
      get 'cross', :on => :member
    end
    resources :full_offers

    resources :contracts do
      get 'resolve', :on => :member
    end

    resources :users
  end

  namespace :docfix do
    resource :home
  end

  root "static#home"

end
