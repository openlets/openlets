class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject}"
    redirect_to root_url, :alert => exception.message
  end

  helper_method :filter_params, :users_for_filter, :categories_for_filter

  before_filter :set_locale

  def set_locale
    @locale = I18n.locale = params[:locale] || (current_user.locale unless current_user.try(:locale).blank?) || I18n.default_locale
    @dir = @locale.to_s == "he" ? "rtl" : "ltr"
  end

  def resource_class
    params[:controller].singularize.classify
  end  

  private

    def filter_params
      params["filter"] ||= {}
    end

    def users_for_filter
      @user ||= User.all
    end

    def categories_for_filter
      @categories ||= Category.all
    end
end