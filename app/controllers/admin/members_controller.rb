class Admin::MembersController < Admin::ResourceController

  private

    def collection
      if current_economy
        @collection ||= end_of_association_chain.where(economy_id: current_economy.id).order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)
      else
        @collection ||= end_of_association_chain.order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)
      end 
    end

end