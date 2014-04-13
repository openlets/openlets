class ChangeTransactionTable < ActiveRecord::Migration
  def change
    rename_column :transactions, :seller_id, :receiving_wallet_id
    rename_column :transactions, :buyer_id,  :sending_wallet_id
  end
end
