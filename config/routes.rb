Rails.application.routes.draw do
  devise_for :users

  # ----- INFO ROUTES -----
  get  'info', to: redirect("/info/home")
  get  'info/home'
  get  'info/experiments'
  get  'info/help'
  get  'info/test'
  get  'info/chart'
  get  'info/data'
  post 'info/mailpost'
  get  'info/new_login'
  get  'info/new_signup'

  # ----- EVENT ROUTES -----
  resources :events
  get       'events/new_login'
  get       'events/new_signup'

  # ----- BOT ROUTES -----
  get 'bot', to: redirect("/bot/home")
  get 'bot/home'
  get 'bot/build'
  get 'bot/build_msg'
  get 'bot/build_log'
  get 'bot/start'
  get 'bot/stop'
  get 'bot/log_show'
  get 'bot/log_reset'
  get 'bot/new_login'
  get 'bog/new_signup'

  # ----- CORE APPLICATION -----
  get 'core', to: redirect("/core/home")
  get 'core/new_login'
  get 'core/new_signup'

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
      get 'cancel' , :on => :member
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
  get 'core/new_login'
  get 'core/new_signup'
  namespace :docfix do
    resource :home do
      get 'contact'
      get 'terms'
      get 'about'
    end

    resources :projects
    resources :issues do
      get 'offer_bf' , :on => :member
      get 'offer_bu' , :on => :member
      get 'offer_buy', :on => :member
    end
    resources :offers do
      get 'cross'   , :on => :member
    end
    resources :offers_bu
    resources :offers_bf
    resources :contracts do
      get 'offer_bf' , :on => :member
      get 'offer_bu' , :on => :member
      get 'offer_buy', :on => :member
    end
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

  mount GrapeSwaggerRails::Engine, at: "/apidocs"

  root "info#home"

end
