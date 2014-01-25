class CreateWishes < ActiveRecord::Migration
  def change
    create_table :wishes do |t|
      t.string :title
      t.string :image
      t.integer :user_id

      t.timestamps
    end
    add_index :wishes, :user_id
  end
end
