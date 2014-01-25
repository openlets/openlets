class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer  :amount
      t.integer  :buyer_id
      t.integer  :seller_id
      t.string   :workflow_state
      t.datetime :state_changed_at
      t.integer  :item_id
      t.string   :transaction_type

      t.timestamps
    end
    add_index :transactions, :buyer_id
    add_index :transactions, :seller_id
    add_index :transactions, :item_id    
  end
end
