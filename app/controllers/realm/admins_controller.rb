class Realm::AdminsController < Realm::ResourceController

  helper_method :resource_class, :all_managers

  def index
    @admins = User.with_role(:admin)
    @admins_for_removal = @admins - [current_user]
    @rest_of_users = User.all - @admins
    
    @admins = @admins.order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)
  end

  def add
    if params[:chosen_user_id].present?
      @user = User.find(params[:chosen_user_id])
      @user.add_role :admin
    end
    redirect_to realm_admins_path
  end

  def remove
    if params[:chosen_user_id].present?
      @user = User.find(params[:chosen_user_id])
      @user.remove_role :admin
    end
    redirect_to realm_admins_path
  end

  private

    def resource_class
      User
    end

end