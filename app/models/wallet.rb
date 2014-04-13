class Wallet < ActiveRecord::Base
  attr_accessible :walletable_type, :walletable_id, :economy_id

  belongs_to :walletable
  belongs_to :economy

  has_many :transactions, dependent: :destroy
  has_many :purchases,    foreign_key: 'sending_wallet_id',   class_name: 'Transaction'
  has_many :sales,        foreign_key: 'receiving_wallet_id', class_name: 'Transaction'

  validates_uniqueness_of :walletable_id, scope: [:walletable_type, :economy_id]
end