class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject}"
    redirect_to root_url, :alert => exception.message
  end

  helper_method :filter_params, :users_for_filter, :categories_for_filter, :current_economy, :current_member

  before_filter :set_locale

  def set_locale
    @locale = I18n.locale = params[:locale] || (current_user.locale unless current_user.try(:locale).blank?) || I18n.default_locale
    @dir = @locale.to_s == "he" ? "rtl" : "ltr"
  end

  def resource_class
    params[:controller].singularize.classify
  end

  def set_filter_param(k,v)
    filter_params[k] = v
  end

  private

    def filter_params
      params["filter"] ||= {}
    end

    def users_for_filter
      @users ||= (current_economy.blank? ? User.all : current_economy.users)
    end

    def categories_for_filter
      @categories ||= (current_economy.blank? ? Category.all : current_economy.categories )
    end

    def current_economy
      @economy ||= Economy.find_by_domain("http://#{request.host}")
    end

    def current_member
      @member ||= current_user.memberships.where(economy_id: current_economy.id).first
    end
        
end