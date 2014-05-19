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
    object = resource
    options[:location] ||= smart_collection_url

    destroy_resource(object)
    respond_with_dual_blocks(object, options, &block)
  end
  alias :destroy! :destroy

  private

    def collection
      if current_economy
        @collection ||= end_of_association_chain.where(economy_id: current_economy.id).order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)
      else
        @collection ||= end_of_association_chain.order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)
      end       
    end
    
    def filtered_collection
      if current_economy
        @filtered_collection ||= end_of_association_chain.where(economy_id: current_economy.id).filter_for(filter_params).order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)
      else
        @filtered_collection ||= end_of_association_chain.filter_for(filter_params).order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)
      end 
    end

end