class Economy < ActiveRecord::Base
  attr_accessible :currency_name, :description, :economy_type, :title, :currency_type, 
                  :domain, :max_debit, :allow_anyone_to_create_items,
                  :allow_anyone_to_create_wishes, :invite_only, :logo, :bg_image
  
  validates_presence_of :title, :economy_type, :currency_name, :currency_type, :domain, :user_id

  mount_uploader :bg_image, ImageUploader
  mount_uploader :logo,     ImageUploader

  belongs_to :user
  has_many :members
  has_many :categories
  has_many :users, through: :members
  has_many :wallets

  after_create :add_admin_role

  def transactions
    Transaction.where('receiving_wallet_id IN (:wallet_ids) OR sending_wallet_id IN (:wallet_ids)', wallet_ids: wallet_ids)
  end

  def add_admin_role
    self.user.add_role :manager, self
  end

  def self.attributes_for_table
    [:id, :logo, :bg_image, :title, :user_id, :domain, :economy_type]
  end

end
