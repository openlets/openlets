class Admin::UsersController < Admin::ResourceController

  def create
    create! do |success, failure|
      success.html do
        @user.economies << current_economy rescue nil
        redirect_to admin_user_path(@user)
      end
    end
  end

  def approve
    current_member.approve!
    redirect_to admin_user_path(resource)
  end

  def ban
    current_member.ban!
    redirect_to admin_user_path(resource)
  end

  def managers
    users = User
    if current_economy
      @users = current_economy.users.joins(:roles).where("roles.resource_id = ? OR roles.name='admin'", current_economy.id).uniq
      @admins_for_removal = @users - users.with_role(:admin)
      @rest_of_users = current_economy.users - @users
      @users = @users.order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)
      render 'managers'
    else
      @users = users.with_role(:admin).uniq
      @admins_for_removal = @users
      @rest_of_users = User.all - @users
      @users = @users.order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)
      render 'admins'
    end
  end

  def add_manager
    @user = User.find(params[:chosen_user_id])
    @user.add_role :economy_manager, current_economy
    redirect_to managers_admin_users_path
  end

  def remove_manager
    @user = User.find(params[:chosen_user_id])
    @user.remove_role :economy_manager, current_economy
    redirect_to managers_admin_users_path
  end

  def add_admin
    @user = User.find(params[:chosen_user_id])
    @user.add_role :admin
    redirect_to managers_admin_users_path
  end

  def remove_admin
    @user = User.find(params[:chosen_user_id])
    @user.remove_role :admin
    redirect_to managers_admin_users_path
  end  

  private

    def collection
      if current_economy
        @collection ||= end_of_association_chain.by_economy_id(current_economy.id).order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)
      else
        @collection ||= end_of_association_chain.order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)
      end 
    end

end