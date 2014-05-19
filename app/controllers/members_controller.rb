class MembersController < ApplicationController
  load_and_authorize_resource
  before_filter :set_user
  before_filter :validate_authorization_for_user, only: [:edit, :update]

  def items
    @items = @member.items
  end

  def show
    # if current_member
    #   id = current_member.id
    #   @conversation = Conversation.where("user_id = ? AND second_user_id = ? OR user_id = ? AND second_user_id = ?", id, id, id, id).first
    # end
  end

  def edit
  end

  def update
    binding.pry
    if @member.update_attributes(params[:member])
      redirect_to @member, notice: 'User was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def transfer
    @transaction = Transaction.new
  end

  def direct_transfer
    @transaction = @member.sales.new(params[:transaction])
    @transaction.buyer_id = current_member.id
    if @transaction.save
      flash[:notice] = "successfully transfered funds"
      redirect_to @member
    else
      render 'transfer'
    end
  end

  private

    def set_user
      @member = Member.find(params[:id])
    end

    def validate_authorization_for_user
      redirect_to root_path unless @member == current_member
    end

end