class Economy < ActiveRecord::Base
  attr_accessible :currency_name, :description, :economy_type, :title, :currency_type, 
                  :domain, :max_debit, :allow_anyone_to_create_items, 
                  :allow_anyone_to_create_wishes, :invite_only, :logo, :bg_image
  
  validates_presence_of :title, :economy_type, :currency_name, :currency_type, :domain

  mount_uploader :bg_image, ImageUploader
  mount_uploader :logo,     ImageUploader

  has_many :members
  has_many :categories
  has_many :users, through: :members
  has_many :wallets

  def transactions
    Transaction.where('receiving_wallet_id IN (:wallet_ids) OR sending_wallet_id IN (:wallet_ids)', wallet_ids: wallet_ids)
  end

end
