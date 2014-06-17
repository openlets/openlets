class Wallet < ActiveRecord::Base

  attr_accessible :walletable_type, :walletable_id, :economy_id

  belongs_to :walletable, polymorphic: true
  belongs_to :economy

  has_many :transactions, dependent: :destroy
  has_many :purchases,    foreign_key: 'sending_wallet_id',   class_name: 'Transaction'
  has_many :sales,        foreign_key: 'receiving_wallet_id', class_name: 'Transaction'

  validates_uniqueness_of :walletable_id, scope: [:walletable_type, :economy_id]
  validates_presence_of   :walletable_id, :walletable_type, :economy_id

  delegate :user, to: :walletable

  def transactions
    Transaction.where("sending_wallet_id = ? OR receiving_wallet_id = ?", id, id)
  end

  def account_balance
    sales.done.sum(&:amount) - purchases.done.sum(&:amount) + final_zero_point
  end

  def hour_balance
    (account_balance.to_f / 60).round(2)
  end

  def final_zero_point
    economy.time_bank? ? economy.zero_point * 60 : economy.zero_point
  end

  def user_name
    "#{user.full_name} (#{user.id})"
  end  

end