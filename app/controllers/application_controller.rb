class ApplicationController < ActionController::Base

  protect_from_forgery
  before_filter :last_update, :last_location, :pages_in_navigation

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
    @last_update = Time.at(0) if @last_update.empty? # clean slate
  end

  def last_location
    @last_location = Location.current
  end

  def pages_in_navigation
    @pages_in_navigation = Page.where(:in_navigation => true)
  end

end
