class AddSeoTitleDescriptionBigLogoToEconomies < ActiveRecord::Migration
  def change
    add_column :economies, :seo_title, :string
    add_column :economies, :seo_description, :string
    add_column :economies, :big_logo, :string
  end
end
