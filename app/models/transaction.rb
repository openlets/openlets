class Transaction < ActiveRecord::Base
  include Filterable
  include Workflow
  include WorkflowExtended

  TRANSACTION_TYPES = [:direct_transfer, :item_purchase, :wish_fulfillment]

  attr_accessible :amount, :sending_wallet_id, :receiving_wallet_id, :item_id, 
                  :transaction_type, :economy_id
  belongs_to :item
  belongs_to :receiving_wallet, class_name: 'Wallet'
  belongs_to :sending_wallet,   class_name: 'Wallet'

  validates_presence_of :receiving_wallet_id, :amount, :sending_wallet_id, :economy_id
  validates_numericality_of :amount

  validate :not_self

  delegate :economy, to: :buyer

  scope :commerce, lambda { where(transaction_type: ['item_purchase', 'direct_transfer']) }
  scope :for_economy, lambda { |economy| where('receiving_wallet_id IN (:wallet_ids) OR sending_wallet_id IN (:wallet_ids)', wallet_ids: economy.wallet_ids) }

  workflow do
    state :done do
      event :cancel, transitions_to: :canceled
    end
    state :canceled
  end

  before_validation :load_economy_validations

  def load_economy_validations
    self.class.send(:include, "MonetaryModels::#{self.economy.currency_type.camelcase}::Transaction".constantize)
  end

  def buyer
    sending_wallet.walletable
  end

  def seller
    receiving_wallet.walletable
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

  def self.transfer(params = {})
    t = self.new(params)
  	t.valid? && t.save
  end

  def transaction_type_name(user)
    receiving_wallet_id == user.id ? "Sale" : "Purchase"
  end

  def self.admin_filter_attr_names
    [:id, :amount, :sending_wallet_id, :receiving_wallet_id, :item_id, :transaction_type, :workflow_state]
  end


  def admin_form_attribute_names
    [:economy_id, :amount, :sending_wallet_id, :receiving_wallet_id, :item_id, :transaction_type]
  end

  def self.admin_form_attr_names
    [:amount, :sending_wallet_id, :receiving_wallet_id, :item_id, :transaction_type]
  end

  private

    def not_self
      errors.add :base, "can't transfer to yourself" if sending_wallet_id == receiving_wallet_id
    end

end