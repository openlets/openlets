class AddWorkflowsToWishes < ActiveRecord::Migration
  def change
    add_column :wishes, :workflow_state, :string
    add_column :wishes, :state_changed_at, :datetime
  end
end
