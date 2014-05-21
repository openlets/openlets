class Realm::UsersController < Realm::ResourceController
  load_and_authorize_resource
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to admin_members_path, :alert => exception.message
  end

  def show
  end

  def create
    create! do |success, failure|
      success.html do
        current_economy.members.create(user_id: resource.id)
        redirect_to admin_member_path(resource.member_for_economy(current_economy))
      end
    end
  end

  def approve
    resource.member_for_economy(current_economy).approve!
    flash[:notice] = "User has was approved"
    redirect_to admin_user_path(resource)
  end

  def ban
    resource.member_for_economy(current_economy).ban!
    flash[:notice] = "User has was banned"
    redirect_to admin_user_path(resource)
  end

  def managers
    users = User
    @users = users.with_role(:admin).uniq
    @admins_for_removal = @users
    @rest_of_users = User.all - @users
    @users = @users.order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)
    render 'admins'
  end

  def add_admin
    unless params[:chosen_user_id].blank?  
      @user = User.find(params[:chosen_user_id])
      @user.add_role :admin
    end
    redirect_to managers_admin_users_path
  end

  def remove_admin
    unless params[:chosen_user_id].blank?
      @user = User.find(params[:chosen_user_id])
      @user.remove_role :admin
    end
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