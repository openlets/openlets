class AddMaxCreditToEconomies < ActiveRecord::Migration
  def change
    add_column :economies, :max_credit, :integer
  end
end
