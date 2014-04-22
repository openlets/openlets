class AddPermissionsFieldsToEconomies < ActiveRecord::Migration
  def change
    add_column :economies, :allow_anyone_to_create_items, :boolean
    add_column :economies, :allow_anyone_to_create_wishes, :boolean
  end
end
