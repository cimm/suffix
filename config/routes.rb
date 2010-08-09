Suffix::Application.routes.draw do

  resources :posts, :path => 'blog', :only => [:index, :show]

  namespace :admin do
    root :to => 'posts#index'
    resources :posts, :except => [:show]
  end

  root :to => 'posts#index'

end