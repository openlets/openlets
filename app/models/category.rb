class Category < ActiveRecord::Base
  include Filterable
  attr_accessible :name, :parent_id, :economy_id

  has_many :subcategories, class_name: "Category", foreign_key: "parent_id", dependent: :destroy
  belongs_to :parent_category, class_name: "Category", foreign_key: "parent_id"
  belongs_to :economy
  
  has_many :category_connections
  has_many :items, through: :category_connections, source: :categoriable, source_type: 'Item'
  has_many :giving_category_connections,    class_name: 'CategoryConnection', as: :categoriable, conditions: { interest_type: 'giving'    }
  has_many :reiciving_category_connections, class_name: 'CategoryConnection', as: :categoriable, conditions: { interest_type: 'receiving' }
  has_many :members_interested_in_receiving, through: :reiciving_category_connections, source: :categoriable, source_type: 'Member'
  has_many :members_interested_in_giving, through: :giving_category_connections, source: :categoriable,       source_type: 'Member'

  validates_presence_of :name, :economy_id

  def full_name
    name
  end

end