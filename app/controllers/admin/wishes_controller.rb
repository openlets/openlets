class Admin::WishesController < Admin::ResourceController

  private
    
    def filtered_collection
      unless @filtered_collection
        result = Wish.filter_for(filter_params)
        result = result.by_economy_id(current_economy.id) if current_economy
        @filtered_collection = result.order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)
      end
      @filtered_collection
    end
    
end