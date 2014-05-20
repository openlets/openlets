module Filterable
  extend ActiveSupport::Concern

  module ClassMethods

    def filter_for(filter_params)
      collection = self
      filter_params.each do|attr, attr_val|
        unless attr_val.blank?
          if collection.respond_to?("by_#{attr.underscore}")
            collection = collection.send("by_#{attr.underscore}", attr_val)
          else
            collection = collection.where(attr => attr_val) 
          end
        end
      end
      collection
    end

    def admin_filter_attr_names
      attribute_names - %w(created_at updated_at state_changed_at)
    end

  end

end