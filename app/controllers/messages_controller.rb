class MessagesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :conversation
  load_and_authorize_resource :message, through: :conversation

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message      = @conversation.messages.new(params[:message])
    @message.user = current_user
    if @message.save
      Mailer.new_message(@message).deliver
      redirect_to conversation_messages_path(@conversation)
    else
      @conversation = Conversation.find(params[:conversation_id])
      @messages = Message.where(conversation_id: @conversation.id).order(:created_at)      
      @user = @conversation.user == current_user ? @conversation.second_user : @conversation.user      
      render 'index'
    end
  end

  def index
    @conversations = current_user.conversations
    @conversation = Conversation.find(params[:conversation_id])
    @messages = Message.where(conversation_id: @conversation.id).order(:created_at)
    @user = @conversation.user == current_user ? @conversation.second_user : @conversation.user
    @message = @conversation.messages.build
  end
  
  

end