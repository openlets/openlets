class MembersController < ApplicationController
  load_and_authorize_resource
  before_filter :set_user
  before_filter :validate_authorization_for_user, only: [:edit, :update]

  def items
    @items = @user.items
  end

  def show
    # if current_member
    #   id = current_member.id
    #   @conversation = Conversation.where("user_id = ? AND second_user_id = ? OR user_id = ? AND second_user_id = ?", id, id, id, id).first
    # end
  end

  def edit
    @user.locations.build unless @user.locations.any?
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def transfer
    @transaction = Transaction.new
  end

  def direct_transfer
    @transaction = @user.sales.new(params[:transaction])
    @transaction.buyer_id = current_member.id
    if @transaction.save
      flash[:notice] = "successfully transfered funds"
      redirect_to @user
    else
      render 'transfer'
    end
  end

  private

    def set_user
      @user = Member.find(params[:id])
    end

    def validate_authorization_for_user
      redirect_to root_path unless @user == current_member
    end

end