class AddWishIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :wish_id, :integer
    add_index :items,  :wish_id
  end
end
