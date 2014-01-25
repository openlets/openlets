class ConversationsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @conversations = current_user.conversations
  end

  def show
    @conversation = Conversation.find(params[:id])
    @user = @conversation.user == current_user ? @conversation.second_user : @conversation.user
    @message = @conversation.messages.build
  end

  def new
    @user = User.find(params[:user_id])
    @conversation = Conversation.new(user_id: current_user.id, second_user_id: @user.id)
    @conversation.messages.build
  end

  def create
    @conversation = current_user.user_conversations.new(params[:conversation])
    @conversation.second_user_id = params[:user_id]
    @message = @conversation.messages.first
    @message.user_id = current_user.id
    if @conversation.save
      Mailer.new_message(@message).deliver
      redirect_to conversation_messages_path(@conversation)
    else
      @user = User.find(params[:user_id])
      render 'new'
    end
  end
  
end