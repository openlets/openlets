class Wallet < ActiveRecord::Base

  attr_accessible :walletable_type, :walletable_id, :economy_id

  belongs_to :walletable, polymorphic: true
  belongs_to :economy

  has_many :transactions, dependent: :destroy
  has_many :purchases,    foreign_key: 'sending_wallet_id',   class_name: 'Transaction'
  has_many :sales,        foreign_key: 'receiving_wallet_id', class_name: 'Transaction'

  validates_uniqueness_of :walletable_id, scope: [:walletable_type, :economy_id]
  validates_presence_of   :walletable_id, :walletable_type, :economy_id

  def transactions
    Transaction.where("sending_wallet_id = ? OR receiving_wallet_id = ?", id, id)
  end

  def account_balance
    sales.sum(&:amount) - purchases.sum(&:amount)
  end

end