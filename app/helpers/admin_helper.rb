module AdminHelper

  def sidebar_link_class(controller, action)
    'active' if params[:controller] == controller && params[:action] == action
  end

end