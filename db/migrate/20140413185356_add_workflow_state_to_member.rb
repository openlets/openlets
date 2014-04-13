class AddWorkflowStateToMember < ActiveRecord::Migration
  def change
    add_column :members, :workflow_state, :string
    add_column :members, :state_changed_at, :datetime
  end
end
