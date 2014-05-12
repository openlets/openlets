class AddFieldToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :national_id, :integer
    add_column :users, :address, :string
    add_column :users, :phone, :string
    add_column :users, :cellphone, :string
    add_column :users, :fax, :string
    add_column :users, :birth_date, :date
    add_column :users, :profession, :string
    add_column :users, :job, :string
    add_column :users, :relationship_status, :string
    add_column :members, :manager_id, :integer
    remove_column :users, :name
  end
end
