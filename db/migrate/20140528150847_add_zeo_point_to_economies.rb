class AddZeoPointToEconomies < ActiveRecord::Migration
  def change
    add_column :economies, :zero_point, :integer, default: 0
  end
end
