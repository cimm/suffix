module ApplicationHelper

  def title(page_title)
    content_for(:title) { "#{page_title} - #{APP_CONFIG['title']}" }
    page_title
  end

  def homepage?
    current_page?(root_path) || current_page?(posts_path)
  end

end
