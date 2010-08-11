class PostsController < ApplicationController

  def index
    @posts = Post.order("created_at desc").limit(10)
  end

  def show
    @post = Post.find_by_permalink(params[:id])
  end

end
