Suffix::Application.routes.draw do

  resources :posts, :path => 'blog', :only => [:index, :show]
  resources :sessions, :only => [:new, :create, :destroy]

  namespace :admin do
    root :to => 'posts#index'
    resources :posts, :except => [:show]
  end

  match 'login', :to => 'sessions#new'
  match 'logout', :to => 'sessions#destroy'
  root :to => 'posts#index'

end
