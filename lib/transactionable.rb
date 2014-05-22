# Shared library for Item and Wish
module Transactionable
  extend ActiveSupport::Concern

  included do
    include Workflow
    include WorkflowExtended
    include Filterable
    
    mount_uploader :image, ImageUploader

    attr_accessible :title, :description, :image, :category_ids

    belongs_to :member
    has_many   :category_connections, as: :categoriable, dependent: :destroy
    has_many   :categories, through: :category_connections
    has_many   :comments,  as: :commentable
    has_one    :location,  as: :locationable, dependent: :destroy

    validates_presence_of :title, :description

    delegate :user, to: :member

    scope :of_approved_members, lambda { where(member_id: Member.approved.pluck(:id)) }
    scope :by_economy_id,     lambda { |id| joins(:member).where("members.economy_id = ?", id) }
    scope :by_search_query,   lambda { |query| where("title || description ILIKE '%#{query}%'") }
    scope :by_category_ids,   lambda { |category_ids| joins(:category_connections).where("category_connections.category_id in(?)", category_ids) }
    scope :not_mine, lambda { |member| where('member_id != ?', member.id) }

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

  end
end