class CreateWallets < ActiveRecord::Migration
  def change
    create_table :wallets do |t|
      t.references :walletable, polymorphic: true
      t.references :economy

      t.timestamps
    end
    add_index :wallets, :walletable_id
    add_index :wallets, :economy_id
  end
end
