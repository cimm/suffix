module LinksHelper

  def homepage?
    current_page?(root_path) || current_page?(posts_path)
  end

  def select_active(paths)
    paths.each do |path|
      return "selected" if current_page?(path)
    end
  end

end
