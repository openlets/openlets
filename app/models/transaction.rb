class Transaction < ActiveRecord::Base
  include Workflow
  attr_accessible :amount, :buyer_id, :seller_id, :item_id, :transaction_type
  belongs_to :item
  belongs_to :buyer,  class_name: 'User'
  belongs_to :seller, class_name: 'User'

  TRANSACTION_TYPES = %w(direct_transfer facebook_login_gift registration_gift first_item_gift 
                        first_item_with_image_gift new_item_gift linkedin_login_gift 
                        google_oauth2_login_gift purchase)

  validates_presence_of :seller_id, :amount
  validates_numericality_of :amount
  validates_inclusion_of :transaction_type, :in => TRANSACTION_TYPES

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
  	self.create!(buyer_id: buyer.id, seller_id: seller.id, item_id: item.id, 
                 amount: item.price, transaction_type: 'purchase')
  end

  def self.registration_gift(user)
    unless self.got_gift?(user, 'registration_gift')
  	  self.create!(seller_id: user.id, amount: Setting[:registration_gift].to_i, 
                   transaction_type: 'registration_gift')
    end
  end

  def self.social_login_gift(auth)
    gift_type = "#{auth.provider}_login_gift"
    gift_amount = Setting[gift_type.to_sym].to_i
    unless self.got_gift?(auth.user, gift_type)
      self.create!(seller_id: auth.user.id, amount: gift_amount, transaction_type: gift_type)
    end
  end

  def self.item_gift(item)
    if item.user.items.count == 1 
      gift_type = 'first_item_gift'
      gift_type = 'first_item_with_image_gift' if item.image.present?
    else
      gift_type = 'new_item_gift'
    end
    gift_amount = Setting[gift_type.to_sym].to_i
    if !self.got_gift?(item.user, gift_type) or gift_type == 'new_item_gift'
      self.create!(seller_id: item.user.id, amount: gift_amount, transaction_type: gift_type)
    end
  end

  def transaction_type_name(user)
    if transaction_type.present?
      transaction_type.titleize
    else
      item.user == user ? "Sale" : "Purchase"
    end
  end

  private

    def sufficient_funds
      if requires_funds? and buyer
    	  errors.add :base, "insufficient funds" if buyer.try(:account_balance) < self.try(:amount)
      end
    end

    def requires_funds?
      transaction_type == 'direct_transfer' or item_id.present?
    end

    def self.got_gift?(user, gift_type)
      user.sales.where(transaction_type: gift_type).any?
    end

    def not_self
      errors.add :base, "can't transfer to yourself" if buyer_id == seller_id
    end

end