class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   :name
      t.string   :image
      t.string   :location
      t.string   :username
      t.string   :workflow_state
      t.text     :about
      t.datetime :state_changed_at

      t.timestamps
    end
  end
end
