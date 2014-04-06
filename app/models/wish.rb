class Wish < ActiveRecord::Base
  include Transactionable

  attr_accessible :image, :title, :user_id, :description, :category_ids

  belongs_to :user
  has_many   :category_connections, as: :categoriable, dependent: :destroy
  has_many   :categories, through: :category_connections
  has_many   :items
  has_one    :location,  as: :locationable, dependent: :destroy

  validates_presence_of :title

  def any_wish_propositions?
    items.any?
  end

end