class Member < ActiveRecord::Base
  include Workflow
  include WorkflowExtended
  rolify

  belongs_to :user
  belongs_to :economy

  has_one :wallet, as: :walletable
  has_many :items
  has_many :wishes

  validates_uniqueness_of :user_id, scope: [:economy_id]

  delegate :account_balance, to: :wallet
  delegate :name, to: :user

  after_create do
    Wallet.create(walletable_type: 'Member', walletable_id: self.id, economy_id: self.economy_id)
  end

  delegate :image, :email, :authorizations, to: :user

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
  workflow_scopes

  def conversations
    Conversation.where("user_id = ? OR second_user_id = ?", id, id)
  end

end