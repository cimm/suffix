class ApplicationController < ActionController::Base

  protect_from_forgery
  before_filter :last_update, :last_location

  def admin?
    session[:admin]
  end

  def last_update
    @last_update = Array.new
    if last_post = Post.last_update
      @last_update << last_post
    end
    if last_page = Page.last_update
      @last_update << last_page
    end
    @last_update = @last_update.sort!.to_s
  end

  def last_location
    @last_location = Location.current
  end

end
