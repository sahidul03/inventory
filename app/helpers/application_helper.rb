module ApplicationHelper
  def flash_class(level)
    case level
      when :notice then "alert alert-info"
      when :success then "alert alert-success"
      when :error then "alert alert-danger"
      when :alert then "alert alert-warning"
    end
  end

  def menu_class_active(c_name)
    if c_name == controller.controller_name
      return 'active'
    else
      return ''
    end
  end

  def sub_menu_class_active(path)
    if current_page? path
      return 'active'
    else
      return ''
    end
  end
end
