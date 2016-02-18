module ApplicationHelper
  def home_url
    url = ""
    if request.fullpath == root_path
      url = root_path.to_s
    end
    url
  end
end
