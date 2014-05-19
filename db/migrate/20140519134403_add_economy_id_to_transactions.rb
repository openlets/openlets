class AddEconomyIdToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :economy_id, :integer
    add_index :transactions, :economy_id
  end
end
