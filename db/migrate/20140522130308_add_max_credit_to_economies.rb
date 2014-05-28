class AddMaxCreditToEconomies < ActiveRecord::Migration
  def change
    add_column :economies, :max_credit, :integer, default: 100
  end
end
