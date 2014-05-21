class Realm::ManagersController < Realm::ResourceController

  helper_method :resource_class, :all_managers

  def index
    if current_economy
      @managers = User.joins(:roles).where("roles.resource_id = ? OR roles.name='admin'", current_economy.id).uniq
      @admins_for_removal = @managers - User.with_role(:admin)
      @rest_of_users = current_economy.users - @managers
    else
      @managers = User.with_role(:admin)
      @admins_for_removal = @managers
      @rest_of_users = User.all - @managers
    end
    
    @managers = @managers.order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)
  end

  def add
    unless params[:chosen_user_id].blank?
      @user = User.find(params[:chosen_user_id])
      @user.add_role :manager, current_economy
    end
    redirect_to admin_managers_path
  end

  def remove
    unless params[:chosen_user_id].blank?
      @user = User.find(params[:chosen_user_id])
      @user.remove_role :manager, current_economy
    end
    redirect_to admin_managers_path
  end

  private

    def resource_class
      User
    end

end