class PostsController < ApplicationController

  respond_to :html, :atom

  def index
    if params[:archive]
      @posts = Post.all
      render :archive and return
    end
    posts = Post.order("created_at desc").limit(20)
    @posts = posts[0..3]
    @archive = posts[4..20]
    # TODO The atom feed only has the last 4 posts, is this enough?
    respond_with @posts
  end

  def show
    @post = Post.find_by_permalink!(params[:id])
    @comment = Comment.new
    @comments = @post.comments.order("created_at asc")
  end

end
