module TopBarHelper

  def nav_link(controller, action, path, text, icon = nil)
    render 'common/nav_link', controller: controller, action: action, path: path, text: text, icon: icon
  end

end