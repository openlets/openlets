class AddDescriptionToWishes < ActiveRecord::Migration
  def change
    add_column :wishes, :description, :text
  end
end
