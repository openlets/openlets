class User < ActiveRecord::Base
  rolify
  include Workflow
  include WorkflowExtended

  devise :database_authenticatable, :registerable, :recoverable, 
         :rememberable, :trackable, :validatable, :omniauthable, :token_authenticatable
  
  attr_accessible :email, :password, :password_confirmation, :name, :about, :locale, :locations_attributes, :image
  
  validates_presence_of :email
  
  mount_uploader :image, ImageUploader

  has_many :authorizations
  
  has_many :user_conversations, class_name: 'Conversation', foreign_key: 'user_id'
  has_many :messages, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :economies
  has_many :memberships, class_name: 'Member', dependent: :destroy
  # has_many :member_of_economies, through: :memberships
  has_many :items,     through: :memberships
  has_many :wishes,    through: :memberships

  has_many :locations, as: :locationable, dependent: :destroy
  accepts_nested_attributes_for :locations

  scope :by_economy_id,     lambda { |id| joins(:memberships).where('members.economy_id = ?', id)}
  scope :awaiting_approval, lambda { where(workflow_state: 'awaiting_approval') }
  scope :approved,          lambda { where(workflow_state: 'approved') }
  scope :banned,            lambda { where(workflow_state: 'banned') }

  LOCALES = ['en', 'he']

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

  def editable_attribute_names
    %w(name email about locale image)
  end

  def unique_authorizations
    authorizations.inject({}) {|h,e| h[e.provider]=e; h}.values
  end

  def member_for_economy(economy)
    memberships.find_by_economy_id(economy.id)
  end

  def is_admin?
    !(["admin", "economy_manager"] & self.roles.map(&:name)).empty?
  end

  def full_name
    return username unless username.blank?
    return name     unless name.blank?
    email.split("@")[0]
  end

  def conversations
    Conversation.where("user_id = ? OR second_user_id = ?", id, id)
  end

  def allowed_messages
    cids = conversations.map(&:id)
    Message.where(conversation_id: cids)
  end

  def connected_with?(provider)
    authorizations.pluck(:provider).include?(provider.to_s)
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def self.from_omniauth(auth, current_user)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s, token: auth.credentials.token, secret: auth.credentials.secret).first_or_initialize
    if authorization.user.blank?
      user = current_user.nil? ? User.where('email = ?', auth["info"]["email"]).first : current_user
      if user.blank?
        user = User.new
        user.password = Devise.friendly_token[0,10]
        user.name = auth.info.name
        user.email = auth.info.email
        user.save
      end
      authorization.username = auth.info.nickname
      authorization.user_id = user.id
      authorization.save
    end
    authorization.user
  end

end