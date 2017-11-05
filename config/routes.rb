Rails.application.routes.draw do
  devise_for :users
  get  'static/home'
  get  'static/help'
  get  'static/test'
  get  'static/chart'
  get  'static/data'
  get  'static/mailthanks'
  post 'static/mailpost'

  get 'core'  , to: redirect("/core/home")
  get 'demo'  , to: redirect("/core/home")
  get 'docfix', to: redirect("/docfix/home")

  namespace :core do

    resource :home

    resources :repos do
      get 'sync', :on => :member
    end
    resources :repo_git_hubs, path: "/core/repos"
    resources :bugs
    resources :bids
    resources :asks
    resources :offers do
      get 'retract', :on => :member
      get 'cross'  , :on => :member
      get 'take'   , :on => :member
    end
    resources :full_offers
    resources :sell_offers

    resources :contracts do
      get 'resolve', :on => :member
      get 'graph'  , :on => :member
      get 'chart'  , :on => :member
    end

    resources :positions
    resources :users
  end

  namespace :docfix do
    resource :home

    resources :projects
    resources :issues
    resources :offers
    resources :contracts

    resource :about

    resources :users
  end

  root "static#home"

end
