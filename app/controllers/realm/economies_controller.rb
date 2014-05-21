class Realm::EconomiesController < Realm::ResourceController

  private
    
    def filtered_collection
      @filtered_collection ||= Economy.filter_for(filter_params).order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)
    end

end