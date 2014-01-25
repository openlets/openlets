class Wish < ActiveRecord::Base
  include Workflow
  include WorkflowExtended

  mount_uploader :image, ImageUploader	
  attr_accessible :image, :title, :user_id, :description, :category_ids

  belongs_to :user
  has_many   :category_connections, as: :categoriable, dependent: :destroy
  has_many   :categories, through: :category_connections
  has_many   :items
  has_one    :location,  as: :locationable, dependent: :destroy

  validates_presence_of :title
  
  scope :of_approved_users, lambda { where(user_id: User.approved.pluck(:id)) }

  workflow do
    state :active do
      event :pause, transitions_to: :paused
      event :ban,   transitions_to: :banned
    end
    state :paused do
      event :reactivate, transitions_to: :active
    end
    state :banned do
      event :reactivate, transitions_to: :active
    end
  end
  workflow_scopes

  scope :not_mine, lambda { |user| where('user_id != ?', user.id) }

end