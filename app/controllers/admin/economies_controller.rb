class Admin::EconomiesController < Admin::ResourceController

  def update
    resource.update_attributes(params[:economy])
    redirect_to admin_settings_path
  end

  private
    
    def collection
      @collection ||= end_of_association_chain.order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)
    end

end