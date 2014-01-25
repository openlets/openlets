class Item < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  include Workflow
  include WorkflowExtended

  attr_accessible :description, :price, :title, :image, :category_ids, :wish_id

  belongs_to :user
  belongs_to :wish
  has_many   :category_connections, as: :categoriable, dependent: :destroy
  has_many   :categories, through: :category_connections
  has_many   :transactions
  has_many   :buyers, through: :transactions
  has_many   :comments,  as: :commentable
  has_one    :location,  as: :locationable, dependent: :destroy

  validates_presence_of :description, :price, :title
  validates_numericality_of :price

  after_create :item_gift

  scope :of_approved_users, lambda { where(user_id: User.approved.pluck(:id)) }

  workflow do
    state :active do
      event :ban,     transitions_to: :banned
      event :pause,   transitions_to: :paused
    end
    state :paused do
      event :activate, transitions_to: :active
      event :ban,     transitions_to: :banned
    end
    state :banned do
      event :activate, transitions_to: :active
      event :pause,   transitions_to: :paused      
    end
  end
  workflow_scopes
  
  def purchase!(buyer)
    if buyer.account_balance >= price
      Transaction.purchase!(buyer, user, self)
    else
      false
    end
  end

  private

    def item_gift
      Transaction.item_gift(self)
    end

end