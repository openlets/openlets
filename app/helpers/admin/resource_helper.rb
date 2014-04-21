module Admin::ResourceHelper

  def attributes
    resource_class.attribute_names - %w(id created_at updated_at)
  end

  def table_attribute_cell(name, attribute)
    return image_tag(attribute, size: '50x50')                                      if name == :image
    return t("admin.settings.#{attribute}")                                         if name == :name && resource_class.name == 'Setting'
    return attribute.strftime("%d/%m/%Y")                                           if name == :created_at
    return link_to User.find(attribute).name,  admin_user_path(attribute)           if [:user_id, :buyer_id, :seller_id].include?(name)
    return link_to Wish.find(attribute).title, admin_wish_path(attribute)           if attribute.present? && name == :wish_id
    return link_to Item.find(attribute).title, admin_item_path(attribute)           if attribute.present? && name == :item_id
    return content_tag(:span, current_member.workflow_state, class: 'label radius') if name == :workflow_state
    return attribute
  end

end