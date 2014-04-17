module Admin::ResourceHelper

  def attributes
    resource_class.attribute_names - %w(created_at updated_at)
  end

end