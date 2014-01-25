class CommentsController < ApplicationController
  load_and_authorize_resource

  def create
    @item = Item.find(params[:item_id])
    @comment = @item.comments.new(params[:comment])
    @comment.user = current_user

    if @comment.save
      flash[:notice] = "Comment was created"
      redirect_to @item
    else
      render 'items/show'
    end
  end

  
end