Suffix::Application.routes.draw do

  resources :sessions, :only => [:new, :create, :destroy]
  resources :posts, :path => 'blog', :only => [:index, :show]
  resources :comments, :only => [:create]
  resources :photos, :only => [:index]
  resources :pages, :only => [:show] # TODO Change routes so that /page-title works

  namespace :admin do
    root :to => 'posts#index'
    resources :posts, :except => [:show]
    resources :pages, :except => [:show]
    resources :locations, :except => [:show]
  end

  match 'login', :to => 'sessions#new'
  match 'logout', :to => 'sessions#destroy'
  root :to => 'posts#index'

end
