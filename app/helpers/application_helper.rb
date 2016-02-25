module ApplicationHelper
  def home_url
    url = ""
    unless request.fullpath == root_path
      url = root_path.to_s
    end
    url
  end
  def active_class(link_path)
	current_page?(link_path) ? "active" : ""
  end
end
