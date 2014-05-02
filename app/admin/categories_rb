ActiveAdmin.register Category do
  menu :parent => 'Configurations'  

  index do
    column :id
    column :name
    column(:parent) { |c| c.parent_category.try(:name) }
    default_actions
  end

  form do |f|
    f.inputs "Category" do
      f.input :name
      f.input :parent_id, as: :select, collection: Category.find(:all)
    end

    f.actions
  end

end
