class AddNameToEconomy < ActiveRecord::Migration
  def change
    add_column :economies, :name, :string
  end
end
