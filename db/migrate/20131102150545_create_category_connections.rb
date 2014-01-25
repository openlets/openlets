class CreateCategoryConnections < ActiveRecord::Migration
  def change
    create_table :category_connections do |t|
      t.string :categoriable_type
      t.integer :categoriable_id
      t.integer :category_id

      t.timestamps
    end
    add_index :category_connections, :categoriable_id
    add_index :category_connections, :categoriable_type
  end
end
