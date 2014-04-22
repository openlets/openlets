class Item < ActiveRecord::Base
  include Transactionable

  attr_accessible :price, :wish_id

  belongs_to :wish

  validates_presence_of :price
  validates_numericality_of :price

  def purchase(buyer)
    Transaction.transfer(buyer, member, self)
  end

end