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
      return %Q[
      <script type='text/javascript' charset='utf-8'>
        sweetAlert('Error',
                   '#{instance.errors.messages.each { |k,v|  "*#{klass.human_attribute_name(k)}: #{v.first}; \\n"  } }',
                   'warning');
      </script>
     ]
    end
  end
end
