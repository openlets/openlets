class Admin::ResourceController < Admin::AdminController
  inherit_resources

  helper_method :filtered_collection

  def create(options={}, &block)
    object = build_resource

    if create_resource(object)
      options[:location] ||= smart_resource_url
    end

    respond_with_dual_blocks(object, options, &block)
  end
  alias :create! :create

  def update(options={}, &block)
    object = resource

    if update_resource(object, resource_params)
      options[:location] ||= smart_resource_url
    end

    respond_with_dual_blocks(object, options, &block)
  end
  alias :update! :update

  def destroy(options={}, &block)

    begin
      resource.destroy
    rescue ActiveRecord::DeleteRestrictionError => e
      resource.errors.add(:base, e)
      flash[:error] = "Can't delete #{resource.class.name}"
      return redirect_to resource_path
    end

    flash[:notice] = "#{resource.class.name} Successfuly deleted."
    redirect_to send("admin_#{resource.class.name.underscore.pluralize}_path")
  end
  alias :destroy! :destroy

  private
    
    def filtered_collection
      if current_economy
        @filtered_collection ||= end_of_association_chain.filter_for(filter_params).where(economy_id: current_economy.id).order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)
      else
        @filtered_collection ||= end_of_association_chain.filter_for(filter_params).order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)
      end 
    end

end