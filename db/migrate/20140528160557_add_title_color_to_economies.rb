class AddTitleColorToEconomies < ActiveRecord::Migration
  def change
    add_column :economies, :title_color, :string
  end
end
