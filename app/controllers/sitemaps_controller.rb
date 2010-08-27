class SitemapsController < ApplicationController

  respond_to :xml

  def show
    @pages = Page.all
    @posts = Post.order("updated_at desc")
  end

end
