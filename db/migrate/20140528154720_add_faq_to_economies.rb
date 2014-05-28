class AddFaqToEconomies < ActiveRecord::Migration
  def change
    add_column :economies, :faq, :text
  end
end
