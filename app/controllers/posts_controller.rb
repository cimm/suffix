class PostsController < ApplicationController

    respond_to :html, :atom

  def index
    @posts = Post.order("created_at desc").limit(10)
    respond_with @posts
  end

  def show
    @post = Post.find_by_permalink(params[:id])
    @comment = Comment.new
    @comments = @post.comments.order("created_at desc")
  end

end
