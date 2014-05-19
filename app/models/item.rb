class Item < ActiveRecord::Base
  include Transactionable

  attr_accessible :price, :wish_id

  belongs_to :wish

  validates_presence_of :price
  validates_numericality_of :price

  def purchase(buyer)
    Transaction.transfer(buyer, member, self)
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

end