class AddCategoryConnectionInterestType < ActiveRecord::Migration
  def change
    add_column :category_connections, :interest_type, :string
  end
end
