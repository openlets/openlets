class Category < ActiveRecord::Base
  attr_accessible :name, :parent_id

  has_many :subcategories, class_name: "Category", foreign_key: "parent_id", dependent: :destroy
  belongs_to :parent_category, class_name: "Category", foreign_key: "parent_id"
  
  has_many :category_connections
  has_many :items, through: :category_connections, source: :categoriable, source_type: 'Item'

  validates_presence_of :name

  def full_name
    name
  end

end