module AdminHelper

  def sidebar_link_class(ctrl)
    'active' if params[:controller] == ctrl
  end

end