class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject}"
    redirect_to root_url, :alert => exception.message
  end

  before_filter :set_locale

  def set_locale
    @locale = I18n.locale = params[:locale] || current_user.try(:locale) || I18n.default_locale
    @dir = @locale.to_s == "he" ? "rtl" : "ltr"
  end

end