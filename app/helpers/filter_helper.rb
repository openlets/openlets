module FilterHelper

  def filter_path_helper
    return items_path  if params[:controller] == "items"
    return wishes_path if params[:controller] == "wishes"
    return root_path   if params[:controller] == "pages"
  end

  def resource_class
    params[:controller].singularize.classify
  end

end