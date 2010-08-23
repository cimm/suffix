class ApplicationController < ActionController::Base

  protect_from_forgery
  before_filter :last_update

  def admin?
    session[:admin]
  end

  def last_update
    @last_update = Array.new
    if last_post = Post.last_update
      @last_update << last_post
    end
    if last_post = Page.last_update
      @last_update << last_post
    end
    @last_update = @last_update.sort!.to_s
  end

end
