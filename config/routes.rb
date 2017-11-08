Rails.application.routes.draw do
  devise_for :users
  get  'static/home'
  get  'static/help'
  get  'static/test'
  get  'static/chart'
  get  'static/data'
  post 'static/mailpost'

  # ----- CORE APPLICATION -----
  get 'core'  , to: redirect("/core/home")
  get 'demo'  , to: redirect("/core/home")
  namespace :core do
    resource :home

    resources :repos do
      get 'sync', :on => :member
    end
    resources :repo_git_hubs, path: "/core/repos"
    resources :bugs
    resources :offers_bu
    resources :offers_bf
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

  # ----- DOCFIX APPLICATION -----
  get 'docfix', to: redirect("/docfix/home")
  namespace :docfix do
    resource :home do
      get 'contact'
      get 'terms'
      get 'about'
    end

    resources :projects
    resources :issues
    resources :offers
    resources :contracts
    resource  :profile do
      get 'my_issues'
      get 'my_offers'
      get 'my_contracts'
      get 'saved_searches'
      get 'my_watchlist'
      get 'my_wallet'
      get 'settings'
    end
  end

  # ----- RESTFUL API -----
  mount ApplicationApi, at: "/api"

  # mount GrapeSwaggerRails::Engine, at: "/apidocs"

  root "static#home"

end
