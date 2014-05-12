module Admin::ResourceHelper

  def attributes
    (resource_class.attribute_names - %w(created_at updated_at state_changed_at)).map &:to_sym
  end

  def table_attribute_cell(name, resource, attribute = nil)
    attribute ||= resource.send(name)
    if attribute
      return attribute.map { |a| content_tag(:span, a.titleize, class: 'label radius') }.join(" ").html_safe if name == :allowed_currency_types or name == :allowed_economy_types
      return attribute == 0 ? "False" : "True"                                                               if name == :allow_anyone_to_create_economy
      return link_to attribute, attribute, target: :blank                                                    if name == :domain
      return image_tag(attribute, size: '50x50')                                                             if name == :image
      return t("admin.settings.#{attribute}")                                                                if name == :name && resource_class.name == 'Setting'
      return attribute.strftime("%d/%m/%Y")                                                                  if name == :created_at
      if name == :workflow_state && params[:controller] == 'admin/users'
        state = resource.member_for_economy(current_economy).workflow_state
        return content_tag(:span, state.titleize, class: "label radius #{workflow_label_color_for(state)}") 
      end
      if name == :workflow_state && params[:controller] == 'admin/members'
        state = resource.workflow_state
        return content_tag(:span, state.titleize, class: "label radius #{workflow_label_color_for(state)}") 
      end
      return link_to Member.find(attribute).full_name, admin_user_path(Member.find(attribute).user)                if name == :member_id
      return link_to Wish.find(attribute).title, admin_wish_path(attribute)                                  if name == :wish_id
      return link_to Item.find(attribute).title, admin_item_path(attribute)                                  if name == :item_id
      return link_to User.find(attribute).name,  admin_user_path(attribute)                                  if [:user_id, :buyer_id, :seller_id].include?(name)
      return attribute
    end
  end

  def workflow_label_color_for(state)
    return "secondary" if state == "awaiting_approval"
    return "success"   if state == "approved"
    return "alert"     if state == "banned"
  end

end