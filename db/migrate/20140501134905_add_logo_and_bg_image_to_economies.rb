class AddLogoAndBgImageToEconomies < ActiveRecord::Migration
  def change
    add_column :economies, :logo, :string
    add_column :economies, :bg_image, :string
  end
end
