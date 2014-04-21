class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject}"
    redirect_to root_url, :alert => exception.message
  end

  helper_method :filter_params, :set_filter_param, :current_economy

  def set_filter_param(k,v)
    filter_params[k] = v
  end

  def filter_params
    params["filter"] ||= {}
  end

  def current_economy
    @current_economy ||= Economy.find_by_domain("http://#{request.host_with_port}")
  end

end