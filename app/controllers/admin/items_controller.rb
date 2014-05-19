class Admin::ItemsController < Admin::ResourceController

  def activate
    resource.approve!
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
    
    def collection
      if current_economy
        @collection ||= end_of_association_chain.where(member_id: current_economy.member_ids).order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)
      else
        @collection ||= end_of_association_chain.order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)
      end 
    end

    def filtered_collection
      if current_economy
        @filtered_collection ||= end_of_association_chain.where(member_id: current_economy.member_ids).filter_for(filter_params).order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)
      else
        @filtered_collection ||= end_of_association_chain.filter_for(filter_params).order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)
      end 
    end

end