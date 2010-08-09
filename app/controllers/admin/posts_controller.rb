class Admin::PostsController < Admin::BaseController

  def index
    @posts = Post.order("created_at desc").limit(10)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])
    if @post.save
      flash[:notice] = "Post successfully saved."
      redirect_to admin_posts_url
    else
      flash[:error] = "This post could not be saved."
      render :new
    end
  end

  def edit
    @post = Post.find_by_permalink(params[:id])
  end

  def update
    @post = Post.find_by_permalink(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to admin_posts_url, :notice => "Post successfully updated."
    else
      flash.now[:error] = "Oops, something went wrong, could update this post."
      render :edit
    end
  end

  def destroy
    @post = Post.find_by_permalink(params[:id])
    if @post.destroy
      flash[:notice] = "Post successfully deleted."
    else
      flash[:error] = "Oops, something went wrong, could not delete this post."
    end
    redirect_to admin_posts_url
  end

end