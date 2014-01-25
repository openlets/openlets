class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.float :latitude
      t.float :longitude
      t.string :locationable_type
      t.integer :locationable_id
      t.string :address
      t.string :city
      t.string :country
      t.string :ip

      t.timestamps
    end
    add_index :locations, :locationable_id
  end
end
