module Admin::ResourceHelper

  def attributes
    (resource_class.attribute_names - %w(created_at updated_at state_changed_at)).map(&:to_sym)
  end

  def table_attribute_cell(name, resource, attribute = nil)
    attribute ||= resource.send(name)
    if attribute
      return attribute.map { |a| content_tag(:span, a.titleize, class: 'label radius') }.join(" ").html_safe if name == :allowed_currency_types or name == :allowed_economy_types
      return attribute == 0 ? "False" : "True"                                                               if name == :allow_anyone_to_create_economy
      return link_to attribute, attribute, target: :blank                                                    if name == :domain
      return link_to resource.economy.title, resource.economy.domain, target: :blank                                         if name == :economy_id && resource.class.name == "Category"
      return image_tag(attribute, size: '65x65')                                                             if [:image, :logo, :bg_image].include?(name)
      return t("admin.settings.#{attribute}")                                                                if name == :name && resource_class.name == 'Setting'
      return attribute.strftime("%d/%m/%Y")                                                                  if [:created_at, :updated_at, :state_changed_at].include?(name)
      if name == :workflow_state
        if params[:controller] == 'admin/users'
          state = resource.member_for_economy(current_economy).workflow_state
        else
          state = resource.workflow_state
        end
        return content_tag(:span, state.titleize, class: "label radius #{workflow_label_color_for(state)}") 
      end
      return content_tag(:span, state.titleize, class: "label radius #{workflow_label_color_for(state)}")    if name == :workflow_state
      return link_to Member.find(attribute).full_name, admin_user_path(Member.find(attribute).user)          if name == :member_id
      return link_to Wish.find(attribute).title, admin_wish_path(attribute)                                  if name == :wish_id
      return link_to Item.find(attribute).title, admin_item_path(attribute)                                  if name == :item_id
      return link_to Category.find(attribute).name, admin_category_path(attribute)                           if name == :parent_id
      return link_to User.find(attribute).full_name,  admin_user_path(attribute)                             if [:user_id, :buyer_id, :seller_id].include?(name)
      return link_to User.find(attribute).full_name,  admin_manager_path(attribute)                          if name == :manager_id
      return link_to Wallet.find(attribute).user.full_name, admin_user_path(Wallet.find(attribute).user.id)  if [:receiving_wallet_id, :sending_wallet_id].include?(name)
      return attribute
    end
  end

  def workflow_label_color_for(state)
    return "secondary" if state == "awaiting_approval"
    return "success"   if state == "approved"
    return "alert"     if state == "banned"
  end

  def html_select_filter_for(collection, prompt, attr_name, attr_id, method_name)
    collection_select(:filter, attr_name, collection, attr_id, method_name, 
      { prompt: prompt, selected: filter_params[attr_name] }, 
      class: "chzn-select auto-submit #{attr_name.downcase}")
  end

  def html_select_tag(collection, attr_name, prompt)
    select_tag "filter[#{attr_name}]", options_for_select(collection, filter_params[attr_name]), class: 'chzn-select auto-submit', include_blank: true, prompt: prompt
  end

  def form_input(f, attr)
    attr = attr.to_s
    if attr == 'locale'
      f.input attr, label: t("forms.#{attr}"), collection: ['en', 'he']
    elsif attr == 'birth_date'
      f.input attr, label: t("forms.#{attr}"), input_html: { class: 'datepicker' }, as: :string
    elsif attr == 'manager_id'
      f.input attr, collection: current_economy.managers, prompt: "Select a Manager", label_method: :full_name, include_blank: true
    else 
      f.input attr, label: t("forms.#{attr}")
    end
  end

end