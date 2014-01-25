class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string   :title
      t.text     :description
      t.integer  :price
      t.string   :image
      t.string   :workflow_state
      t.integer  :user_id
      t.datetime :state_changed_at

      t.timestamps
    end
    add_index :items, :user_id
  end
end
