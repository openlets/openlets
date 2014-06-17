class Admin::ItemsController < Admin::ResourceController

  def activate
    resource.activate!
    flash[:notice] = "Item was approved"
    redirect_to admin_item_path(resource)
  end

  def pause
    resource.pause!
    flash[:notice] = "Item was paused"
    redirect_to admin_item_path(resource)
  end

  def ban
    resource.ban!
    flash[:notice] = "Item was banned"
    redirect_to admin_item_path(resource)
  end

  private

    def filtered_collection
      unless @filtered_collection
        result = Item.filter_for(filter_params)
        result = result.by_economy_id(current_economy.id) if current_economy
        @filtered_collection = result.order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)
      end
      @filtered_collection
    end

end