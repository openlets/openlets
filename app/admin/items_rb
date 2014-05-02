ActiveAdmin.register Item do
	actions :all, except: [:destroy]

  member_action :ban do
    resource.ban!
    redirect_to action: :show
  end

  member_action :publish do
    resource.publish!
    redirect_to action: :show
  end

  action_item only: :show do
    link_to('Ban', action: :ban) unless item.banned?
  end

  action_item only: :show do
    link_to('Republish', action: :publish) if item.banned?
  end

  index do
    column :id
    column(:image) { |i| image_tag(i.image, height: 50) }    
    column(:title)  { |t| link_to(t.title, admin_item_path(t)) }
    column :description
    column :price
    column :workflow_state
    column :created_at
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :user, input_html: { disabled: true }
      f.input :title
      f.input :description
      f.input :price
      f.input :image
      f.input :categories
      f.input :wish
    end

    f.actions
  end


end