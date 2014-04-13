class CreateEconomies < ActiveRecord::Migration
  def change
    create_table :economies do |t|
      t.string :title
      t.text :description
      t.string :economy_type
      t.string :currency_name
      t.string :currency_type

      t.timestamps
    end
  end
end
