class CommentsController < ApplicationController

  def create
    @comment = Comment.new(params[:comment])
    @post = Post.find(params[:comment][:post_id])
    @comment.post = @post
    if @comment.save
      redirect_to post_url(@post), :notice => "Comment successfully saved."
    else
      @comments = @post.comments.order("created_at desc")
      flash[:error] = "This post could not be saved."
      render "posts/show"
    end
  end

end
