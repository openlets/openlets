module AdminHelper

  def sidebar_link_class(controller, action)
    'active' if params[:controller] == controller and action == params[:action]
  end

end