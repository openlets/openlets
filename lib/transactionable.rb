# Shared library for Item and Wish
module Transactionable
  extend ActiveSupport::Concern

  included do
    include Workflow
    include WorkflowExtended
    mount_uploader :image, ImageUploader

    scope :of_approved_users, lambda { where(user_id: User.approved.pluck(:id)) }
    scope :by_category_ids,   lambda { |category_ids| joins(:category_connections).where("category_connections.category_id in(?)", category_ids) }
    scope :not_mine, lambda { |user| where('user_id != ?', user.id) }

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
      resource = self.of_approved_users.active
      resource = resource.by_category_ids(filter_params[:category_ids]) unless filter_params[:category_ids].blank?
      resource = resource.where(user_id: filter_params[:user_id]) unless filter_params[:user_id].blank?
      resource.search(filter_params[:search]) unless filter_params[:search].blank?
      resource
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
