class Transaction < ActiveRecord::Base
  include Workflow
  attr_accessible :amount, :buyer_id, :seller_id, :item_id, :transaction_type
  belongs_to :item
  belongs_to :buyer,  class_name: 'User'
  belongs_to :seller, class_name: 'User'

  validates_presence_of :seller_id, :amount, :buyer_id
  validates_numericality_of :amount

  validate :sufficient_funds, :not_self

  scope :commerce, lambda { where(transaction_type: ['purchase', 'direct_transfer']) }

  workflow do
    state :done do
      event :cancel, transitions_to: :canceled
    end
    state :canceled
  end

  def self.market_velocity
    transactions = Transaction # TODO scope by commerce type transactions
    start_date = transactions.order('created_at ASC').first.created_at.to_date
    end_date   = transactions.order('created_at ASC').last.created_at.to_date
    result = {}
    (start_date..end_date).each do |date|
      result[date] = transactions.where("created_at::date = ?", date).sum &:amount
    end
    result
  end

  def self.purchase!(buyer, seller, item)
  	self.create!(buyer_id: buyer.id, seller_id: seller.id, item_id: item.id, amount: item.price)
  end

  def transaction_type_name(user)
    seller_id == user.id ? "Sale" : "Purchase"
  end

  private

    def sufficient_funds
  	  errors.add :base, "insufficient funds" if (buyer.account_balance - amount) < Setting[:maximum_debit].to_i
    end

    def not_self
      errors.add :base, "can't transfer to yourself" if buyer_id == seller_id
    end

end