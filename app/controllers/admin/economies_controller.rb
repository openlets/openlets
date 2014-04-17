class Admin::EconomiesController < Admin::ResourceController

  private
    
    def collection
      @collection ||= end_of_association_chain.order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)
    end

end