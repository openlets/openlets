class RegistrationsController < Devise::RegistrationsController

  def create
    existing_user = User.find_by_email(params[:user][:email])

    if existing_user
      if current_economy
        existing_member = existing_user.memberships.find_by_economy_id(current_economy.id)
        if existing_member
          flash[:alert] = "Member already exists"
          render 'new'
        else
          current_economy.users << existing_user
          sign_in(:user, existing_user)
          flash[:notice] = "Signup was successful"
          redirect_to root_path
        end
      else
        flash[:alert] = "User already exists"
        render 'new'
      end
    else
      @user = User.new(params[:user])
      if current_economy
        if @user.save
          current_economy.users << @user
          sign_in(:user, @user)
          flash[:notice] = "Signup was successful"
          redirect_to root_path
        else
          flash[:notice] = "User already exists"
          render 'new'
        end
      else
        if @user.save
          sign_in(:user, @user)
          redirect_to root_path
        else
          render 'new'
        end
      end
    end
  end

end


