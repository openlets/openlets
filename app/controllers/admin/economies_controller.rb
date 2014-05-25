class Admin::EconomiesController < Admin::ResourceController

  def update
    @economy = resource
    if @economy.update_attributes(params[:economy])
      flash[:notice] = t('flash_messages.economy_updated_successfully')
      redirect_to admin_settings_path
    else
      render 'admin/settings/economy_settings'
    end
  end

  private
    
    def filtered_collection
      @filtered_collection ||= end_of_association_chain.order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)
    end

end