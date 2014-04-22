# Shared library for Item and Wish
module Transactionable
  extend ActiveSupport::Concern

  included do
    include Workflow
    include WorkflowExtended
    mount_uploader :image, ImageUploader

    attr_accessible :title, :description, :image, :category_ids

    belongs_to :member
    has_many   :category_connections, as: :categoriable, dependent: :destroy
    has_many   :categories, through: :category_connections
    has_many   :comments,  as: :commentable
    has_one    :location,  as: :locationable, dependent: :destroy

    validates_presence_of :title, :description

    delegate :user, to: :member

    scope :of_approved_users, lambda { where(member_id: User.approved.pluck(:id)) }
    scope :by_economy_id, lambda { |id| where(member_id: Economy.find(id).member_ids) }
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

  module ClassMethods

    def filter_by(filter_params)
      collection = self.of_approved_users.active
      collection = collection.by_economy_id(filter_params[:economy_id])     unless filter_params[:economy_id].blank?
      collection = collection.by_category_ids(filter_params[:category_ids]) unless filter_params[:category_ids].blank?
      collection = collection.where(member_id: filter_params[:member_id])   unless filter_params[:member_id].blank?
      collection.search(filter_params[:search])                             unless filter_params[:search].blank?
      collection
    end

    def search(search)
      if search
        find(:all, :conditions => ['title LIKE ?', "%#{search}%"])
      else
        find(:all)
      end
    end

  end


end
