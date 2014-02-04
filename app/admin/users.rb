ActiveAdmin.register User do
  menu :parent => 'User Management'
  actions :all, :except => :destroy

  member_action :approve do
    resource.approve!
    redirect_to action: :show
  end

  member_action :ban do
    resource.ban!
    redirect_to action: :show
  end

  action_item only: :show do
    link_to('Approve', action: :approve) unless user.approved?
  end

  action_item only: :show do
    link_to('Suspend', action: :ban) unless user.banned?
  end

  index do
    column :id
    column(:image) { |u| image_tag(u.image, height: 50) }
    column :name
    column :email
    column :location
    column :workflow_state
    column :about
    column :account_balance
    column(:suspend) { |u| link_to 'Suspend', ban_admin_user_path(u), class: 'button alert', confirm: 'Are you sure?' }
    column(:approve) { |u| link_to 'Approve', approve_admin_user_path(u.id), class: 'button' if u.awaiting_approval? }
    
    default_actions
  end

end