ActiveAdmin.register Transaction do
  actions :all, :except => [:destroy, :edit]

  member_action :cancel do
    resource.cancel!
    redirect_to action: :show
  end

  action_item only: :show do
    link_to('Cancel', action: :cancel)
  end

  index do
    column :id
    column(:buyer)  { |t| link_to(t.buyer.try(:name),  admin_user_path(t.buyer))  if t.buyer  }
    column(:seller) { |t| link_to(t.seller.try(:name), admin_user_path(t.seller)) if t.seller }
    column(:item)   { |t| link_to(t.item.try(:title),  admin_item_path(t.item))   if t.item   }
    column :workflow_state
    column :transaction_type
    column :created_at
    column(:cancel) { |t| link_to('Cancel', cancel_admin_transaction_path(t), class: 'button' ) }
    default_actions
  end

  show do |transaction|
    attributes_table do
      row :id
      row :seller
      row :buyer
      row :amount
      row :workflow_state
    end
  end

  form do |f|
    f.inputs do
      f.input :buyer
      f.input :seller
      f.input :item
      f.input :amount
      f.input :transaction_type, :as => :select, :collection => Transaction::TRANSACTION_TYPES
      f.actions
    end
  end

end
