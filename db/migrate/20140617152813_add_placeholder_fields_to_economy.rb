class AddPlaceholderFieldsToEconomy < ActiveRecord::Migration
  def change
    add_column :economies, :add_item_form_title,          :string, default: 'Add a Item'
    add_column :economies, :add_wish_form_title,          :string, default: 'Add a Wish'
    add_column :economies, :item_title_placeholder,       :string, default: 'Title'
    add_column :economies, :item_description_placeholder, :string, default: 'Description'
    add_column :economies, :wish_title_placeholder,       :string, default: 'Title'
    add_column :economies, :wish_description_placeholder, :string, default: 'Description'
  end
end
