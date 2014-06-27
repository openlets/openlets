class UsersController < ApplicationController
  load_and_authorize_resource
  before_filter :set_user, only: [:complete_profile, :update_complete_profile, :show, :edit, :direct_transfer]

  def complete_profile
  end

  def items
    @items = @user.items
  end

  def show
    if current_user
      id = current_user.id
      @conversation = Conversation.where("user_id = ? AND second_user_id = ? OR user_id = ? AND second_user_id = ?", id, id, id, id).first
    end
  end

  def edit
    @user.locations.build unless @user.locations.any?
  end

  def update
    if @user.update_attributes(params[:user])
      if current_economy
        if params[:complete_profile] == "true"
          redirect_to root_path, notice: 'Thanks for completing your profile!'
        else
          redirect_to @user.member_for_economy(current_economy), notice: 'Profile was successfully updated.'
        end
      else
        redirect_to @user, notice: 'Profile was successfully updated.'
      end
    else
      if params[:complete_profile] == "true"
        flash[:error] = "Your missing some details"
        render action: 'complete_profile'
      else
        render action: 'edit'
      end
    end
  end

  def transfer
    @transaction = Transaction.new
  end

  def direct_transfer
    @transaction = @user.sales.new(params[:transaction])
    @transaction.buyer_id = current_user.id
    if @transaction.save
      flash[:notice] = "successfully transfered funds"
      redirect_to @user
    else
      render 'transfer'
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

end