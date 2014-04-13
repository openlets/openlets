class Member < ActiveRecord::Base
  include Workflow
  include WorkflowExtended

  belongs_to :user
  belongs_to :economy

  has_one :wallet, as: :walletable

  validates_uniqueness_of :user_id, scope: [:economy_id]

  after_create do
    Wallet.create(walletable_type: 'Member', walletable_id: self.id, economy_id: self.economy_id)
  end

  workflow do
    state :awaiting_approval do
      event :approve, transitions_to: :approved
      event :ban, transitions_to: :banned
    end
    state :approved do
      event :ban, transitions_to: :banned
    end
    state :banned do
      event :approve, transitions_to: :approved
    end
  end  

end