class Item < ActiveRecord::Base
  include Transactionable

  attr_accessible :description, :price, :title, :image, :category_ids, :wish_id

  belongs_to :user
  belongs_to :wish
  has_many   :category_connections, as: :categoriable, dependent: :destroy
  has_many   :categories, through: :category_connections
  has_many   :transactions
  has_many   :buyers, through: :transactions
  has_many   :comments,  as: :commentable
  has_one    :location,  as: :locationable, dependent: :destroy

  validates_presence_of :description, :price, :title
  validates_numericality_of :price

  def purchase!(buyer)
    if (buyer.account_balance - price) >= buyer.max_debit
      Transaction.purchase!(buyer, user, self)
    else
      false
    end
  end

end