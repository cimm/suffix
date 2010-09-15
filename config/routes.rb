Suffix::Application.routes.draw do

  resources :sessions, :only => [:new, :create, :destroy]
  resources :posts, :path => 'blog', :only => [:index, :show]
  resources :comments, :only => [:create]
  resources :photos, :only => [:index]
  resource  :search, :only => [:show]
  resource  :sitemap, :only => [:show]

  namespace :admin do
    root :to => 'posts#index'
    resources :posts, :except => [:show]
    resources :pages, :except => [:show]
    resources :locations, :except => [:show]
    resources :tags, :except => [:show]
  end

  match '/feeds/blog.xml' => 'posts#index', :format => :atom # redirect old RSS feed
  match 'archive(/)' => 'posts#index', :as => :archive, :defaults => { :archive => 'true' } # TODO needs to be RESTful... or not?

  resources :pages, :path => "/", :only => [:show]

  root :to => 'posts#index'

end
