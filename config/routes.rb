TvBroadcast::Application.routes.draw do
  get '/auth/facebook', :as => :facebook_auth
  get '/auth/facebook/callback', :to => 'sessions#create'
  get '/auth/failure', :to => 'sessions#failure'

  get    '/login',  :to => 'sessions#new',     :as => :login
  delete '/logout', :to => 'sessions#destroy', :as => :logout

  resources :users

  resources :programs, :only => [:index, :show, :new, :create] do
    member do
      get :download
    end

    resources :gif_animations, :only => [:create]
  end

  resources :gif_animations, :only => [:show]

  resources :histories, :only => [:create]

  root 'programs#index'
end
