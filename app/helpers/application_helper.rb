module ApplicationHelper

  def title(page_title)
    content_for(:title) { "#{page_title} - #{Suffix::APPLICATION_TITLE}" }
    page_title
  end

end