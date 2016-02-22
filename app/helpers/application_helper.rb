module ApplicationHelper
  def home_url
    url = ""
    unless request.fullpath == root_path
      url = root_path.to_s
    end
    url
  end
end
