class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.references :user
      t.references :economy

      t.timestamps
    end
    add_index :members, :user_id
    add_index :members, :economy_id
  end
end
