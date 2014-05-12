module AdminHelper

  def sidebar_link_class(controller)
    'active' if params[:controller].include?(controller) or
    params[:controller].include?('users') && controller == 'members'
  end

end