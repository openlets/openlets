module FilterHelper

  def filter_path_helper
    return items_path  if params[:controller] == "items"
    return wishes_path if params[:controller] == "wishes"
    return root_path   if params[:controller] == "pages"
  end

  def users_for_filter
    @users ||= (current_economy.blank? ? User.all : current_economy.users)
  end

  def categories_for_filter
    @categories ||= (current_economy.blank? ? Category.all : current_economy.categories )
  end

  def resource_class
    params[:controller].singularize.classify
  end

end