class AddDomainToEconomies < ActiveRecord::Migration
  def change
    add_column :economies, :domain, :string
  end
end
