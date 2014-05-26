class User < ActiveRecord::Base
  rolify
  include Workflow
  include WorkflowExtended
  include Filterable

  devise  :database_authenticatable, :registerable, :recoverable, 
          :rememberable, :trackable, :validatable, :omniauthable, 
          :token_authenticatable
  
  attr_accessible :first_name, :last_name, :username, :email, :about, 
                  :locale, :image, :password, :password_confirmation,
                  :national_id, :address, :phone, :cellphone, :fax,
                  :birth_date, :profession, :job, :relationship_status,
                  :location
  
  validates_presence_of :email
  
  mount_uploader :image, ImageUploader

  has_many :authorizations
  has_many :user_conversations, class_name: 'Conversation', foreign_key: 'user_id'
  has_many :managed_members, class_name: 'Member', foreign_key: 'manager_id'
  has_many :messages, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :economies
  has_many :memberships, class_name: 'Member', dependent: :destroy
  has_many :items,     through: :memberships
  has_many :wishes,    through: :memberships

  has_many :locations, as: :locationable, dependent: :destroy
  accepts_nested_attributes_for :locations

  scope :by_economy_id,     lambda { |id| joins(:memberships).where('members.economy_id = ?', id)}
  
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
  workflow_scopes

  def self.admin_filter_attr_names
    [:id, :username, :workflow_state, :email]
  end

  def editable_attribute_names
    %w(image first_name last_name username email about national_id 
       address phone cellphone fax birth_date profession job 
       relationship_status locale)
  end

  def self.admin_attribute_names
    %w(first_name last_name username email image about national_id 
      address phone cellphone fax birth_date profession job 
      relationship_status location locale password password_confirmation)
  end

  def self.admin_table_attribute_names
    %w(image first_name last_name username email locale)
  end

  def unique_authorizations
    authorizations.inject({}) {|h,e| h[e.provider]=e; h}.values
  end

  def member_for_economy(economy)
    memberships.find_by_economy_id(economy.id)
  end

  def is_admin?
    !(["admin", "manager"] & self.roles.map(&:name)).empty?
  end

  def full_name
    return "#{first_name.titleize} #{last_name.titleize}" if first_name and last_name
    return username unless username.blank?
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
        user.password   = Devise.friendly_token[0,10]
        user.first_name = auth.info.name
        user.email      = auth.info.email
        user.save
      end
      authorization.username = auth.info.nickname
      authorization.user_id = user.id
      authorization.save
    end
    authorization.user
  end


end