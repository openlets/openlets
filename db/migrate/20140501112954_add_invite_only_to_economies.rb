class AddInviteOnlyToEconomies < ActiveRecord::Migration
  def change
    add_column :economies, :invite_only, :boolean
  end
end
