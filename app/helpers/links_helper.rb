module LinksHelper

  def homepage?
    current_page?(root_path) || current_page?(posts_path)
  end

  def select_active(paths)
    paths.each do |path|
      return "selected" if current_page?(path) || (path != root_path && path != admin_root_path && request.fullpath.starts_with?(path))
      # TODO will highlight the blog link when a page permalink starts with /blog.*/
    end
  end

end
