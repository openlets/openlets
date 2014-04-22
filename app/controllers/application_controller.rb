class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject}"
    redirect_to root_url, :alert => exception.message
  end

  helper_method :filter_params, :set_filter_param, :current_economy, :current_member, :member_signed_in?

  def set_filter_param(k,v)
    filter_params[k] = v
  end

  def filter_params
    params["filter"] ||= {}
  end

  def current_economy
    @current_economy ||= Economy.find_by_domain("http://#{request.host_with_port}")
  end

  def current_ability
    if current_economy
      @current_ability ||= Ability.new(current_user, current_member, current_economy)
    else
      @current_ability ||= Ability.new(current_user)
    end
  end

  def current_member
    if current_user
      @member ||= (current_economy ? current_user.memberships.where(economy_id: current_economy.id).first : current_user)
    end
  end

  def member_signed_in?
    # current_member.blank?
    current_user.memberships.map(&:economy_id).include?(current_economy.id)
  end  

end