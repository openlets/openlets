class Economy < ActiveRecord::Base
  include Filterable

  attr_accessible :currency_name, :description, :economy_type, :title, :currency_type,
                  :domain, :max_debit, :max_credit, :allow_anyone_to_create_items,
                  :allow_anyone_to_create_wishes, :invite_only, :logo, :bg_image
  
  validates_presence_of :title, :economy_type, :currency_name, :currency_type, 
                        :domain, :user_id, :max_credit

  mount_uploader :bg_image, ImageUploader
  mount_uploader :logo,     ImageUploader

  belongs_to :user
  has_many :members
  has_many :items,  through: :members
  has_many :wishes, through: :members
  has_many :users,  through: :members
  has_many :categories
  has_many :wallets
  has_many :transactions

  after_create :add_admin_role

  before_validation :load_economy_validations

  def load_economy_validations
    self.class.send(:include, "MonetaryModels::#{self.currency_type.camelcase}::Economy".constantize)
  end

  ECONOMY_TYPES  = %w(community cooperative business non_profit)
  CURRENCY_TYPES = %w(time_bank mutual_credit)
   # fiat backed linked

  def managers
    users.joins(:roles).where("roles.resource_id = ? OR roles.name='admin'", id).uniq
  end

  def add_admin_role
    self.user.add_role :manager, self
  end

  def self.realm_attributes_for_table
    [:id, :logo, :bg_image, :title, :user_id, :domain, :economy_type, :currency_type]
  end

  def self.attributes_for_table
    [:id, :logo, :bg_image, :title, :user_id, :domain, :economy_type]
  end

  def self.admin_filter_attr_names
    [:id, :title, :description, :currency_name, :currency_type, :domain, :economy_type]
  end

  def currency_type_is?(model)
    currency_type == model.to_s
  end

  def time_bank?
    currency_type == "time_bank"
  end

end
