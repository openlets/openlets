module AdminHelper

  def sidebar_link_class(controller, action)
    'active' if params[:controller] == controller and action == params[:action]
  end

  def unique_body_class(params)
    c = params[:controller].dup
    c["/"] = "-"
    "#{c}-#{params[:action]}"
  end

end