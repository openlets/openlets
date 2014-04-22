class Transaction < ActiveRecord::Base
  include MonetaryModels::MutualCredit
  include Workflow
  include WorkflowExtended

  attr_accessible :amount, :sending_wallet_id, :receiving_wallet_id, :item_id, :transaction_type
  belongs_to :item
  belongs_to :receiving_wallet, class_name: 'Wallet'
  belongs_to :sending_wallet,   class_name: 'Wallet'

  validates_presence_of :receiving_wallet_id, :amount, :sending_wallet_id
  validates_numericality_of :amount

  validate :not_self

  scope :commerce, lambda { where(transaction_type: ['purchase', 'direct_transfer']) }

  workflow do
    state :done do
      event :cancel, transitions_to: :canceled
    end
    state :canceled
  end

  def buyer
    sending_wallet.walletable
  end

  def seller
    receiving_wallet.walletable
  end

  def economy
    buyer.economy
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

  def self.transfer(buyer, seller, item)
  	if self.create(sending_wallet_id: buyer.wallet.id, receiving_wallet_id: seller.wallet.id, item_id: item.id, amount: item.price)
      true
    else
      false
    end
  end

  def transaction_type_name(user)
    receiving_wallet_id == user.id ? "Sale" : "Purchase"
  end

  private

    def not_self
      errors.add :base, "can't transfer to yourself" if sending_wallet_id == receiving_wallet_id
    end

end