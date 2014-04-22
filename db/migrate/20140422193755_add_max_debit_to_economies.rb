class AddMaxDebitToEconomies < ActiveRecord::Migration
  def change
    add_column :economies, :max_debit, :integer, default: -100
  end
end
