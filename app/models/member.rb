class Member < ActiveRecord::Base
  include Workflow
  include WorkflowExtended
  include Filterable
  rolify

  belongs_to :user
  belongs_to :economy
  belongs_to :manager, class_name: 'User', foreign_key: 'manager_id'

  has_one  :wallet, as: :walletable, dependent: :destroy
  has_many :items
  has_many :wishes
  has_many :giving_category_connections,    class_name: 'CategoryConnection', as: :categoriable, conditions: { interest_type: 'giving'}
  has_many :receiving_category_connections, class_name: 'CategoryConnection', as: :categoriable, conditions: { interest_type: 'receiving'}
  has_many :receiving_categories, through: :receiving_category_connections, source: :category
  has_many :giving_categories,    through: :giving_category_connections,    source: :category


  has_many   :category_connections, as: :categoriable, dependent: :destroy
  has_many   :categories, through: :category_connections


  validates_uniqueness_of :user_id, scope: [:economy_id]

  delegate :account_balance, to: :wallet
  delegate :hour_balance, to: :wallet
  delegate :full_name, :company_name, :company_site, :company_site_with_http, :office_number, to: :user

  after_create do
    Wallet.create(walletable_type: 'Member', walletable_id: self.id, economy_id: self.economy_id)
  end

  delegate :image, :email, :authorizations, :unique_authorizations, :full_name, to: :user

  attr_accessible :user_id, :member_id, :receiving_category_ids, :giving_category_ids, :manager_id

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

  def balance
    economy.time_bank? ? hour_balance : account_balance
  end

  def conversations
    Conversation.where("user_id = ? OR second_user_id = ?", id, id)
  end

  def full_name_with_id
    full_name + " (#{self.id})"
  end

end