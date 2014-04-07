class Admin::AdminController < ApplicationController
  before_filter :authenticate_admin_user!
  helper_method :sort_column, :sort_direction, :resource, :resources

  def dashboard
    
  end

  def authenticate_admin_user!
    redirect_to root_path, alert: "You are not authorized to access this page" unless current_user.has_role? :admin
  end

  def sort_column
    resource_class.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def resource
    @resource ||= resource_class.find(params[:id])
  end

end