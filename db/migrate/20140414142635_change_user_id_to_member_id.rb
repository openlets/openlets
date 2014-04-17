class ChangeUserIdToMemberId < ActiveRecord::Migration
  def change
    rename_column :items, :user_id, :member_id
    rename_column :wishes, :user_id, :member_id
    add_index     :items, :member_id
    add_index     :wishes, :member_id
  end
end
