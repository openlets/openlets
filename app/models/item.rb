class Item < ActiveRecord::Base
  include Transactionable

  attr_accessible :price, :wish_id, :wish

  belongs_to :wish

  validates_presence_of :price
  validates_numericality_of :price

  def purchase(buyer)
    Transaction.transfer({
      sending_wallet_id:   buyer.wallet.id,
      receiving_wallet_id: member.wallet.id,
      economy_id: member.economy.id,
      item_id: self.id,
      amount:  self.price
    })
  end

  def self.admin_filter_attr_names
    [:id, :title, :description, :price, :workflow_state, :member_id, :wish_id]
  end

  def member_name
    member.full_name
  end

  def wish_name
    wish.try(:title)
  end

  def title_with_id
    "#{title} (#{id})"
  end

end