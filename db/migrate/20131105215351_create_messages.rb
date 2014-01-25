class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string  :text
      t.integer :conversation_id
      t.integer :user_id
      t.timestamps
    end
    add_index :messages, :user_id
    add_index :messages, :conversation_id
  end
end