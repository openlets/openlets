class AddEconomyIdToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :economy_id, :integer
    add_index  :categories, :economy_id
  end
end
