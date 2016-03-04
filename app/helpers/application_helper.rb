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
  def instance_errors(klass, instance)
    unless instance.errors.empty?
      errors = ''
      instance.errors.messages.each do |k,v|
        errors += "*#{klass.human_attribute_name(k)}: #{v.first}; \\n"
      end
      return %Q[
        sweetAlert('Error',
                   '#{ errors } ',
                   'warning');
     ]
    end
  end
end
