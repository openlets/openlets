class AddArrayFieldToSetting < ActiveRecord::Migration
  def change
    add_column :settings, :array, :string
  end
end
