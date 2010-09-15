module ApplicationHelper

  def title(page_title)
    content_for(:title) { "#{page_title.capitalize} - #{APP_CONFIG['title']}" }
    page_title
  end

  def admin?
    session[:admin]
  end

end
