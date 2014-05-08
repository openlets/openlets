class AddUserIdToEconomies < ActiveRecord::Migration
  def change
    add_column :economies, :user_id, :integer
    add_index  :economies, :user_id
  end
end
