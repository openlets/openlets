class ChangeSettingValueFromIntegerToString < ActiveRecord::Migration
  def up
    change_column :settings, :value, :string
  end
  def down
    change_column :settings, :value, :integer
  end
end
