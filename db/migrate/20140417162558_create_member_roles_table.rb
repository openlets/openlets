class CreateMemberRolesTable < ActiveRecord::Migration
  def change
    create_table(:members_roles, :id => false) do |t|
      t.references :member
      t.references :role
    end

    add_index(:members_roles, [ :member_id, :role_id ])
  end
end
