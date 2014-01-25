class CategoryConnection < ActiveRecord::Base
  attr_accessible :categoriable_id, :categoriable_type, :category_id
  belongs_to :categoriable, polymorphic: true
  belongs_to :category
  
  validates_presence_of :categoriable_id, :categoriable_type, :category_id
end