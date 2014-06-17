class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :company_name, :string
    add_column :users, :company_site, :string
    add_column :users, :office_number, :string
  end
end
