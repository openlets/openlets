class User < ActiveRecord::Base
  include Workflow
  include WorkflowExtended

  devise :database_authenticatable, :registerable, :recoverable, 
         :rememberable, :trackable, :validatable, :omniauthable, :token_authenticatable
  
  attr_accessible :email, :password, :password_confirmation, :name, :about, :locale, :locations_attributes
  
  validates_presence_of :email
  
  mount_uploader :image, ImageUploader

  has_many :authorizations, dependent: :destroy
  has_many :items,          dependent: :destroy
  has_many :wishes,         dependent: :destroy
  has_many :transactions,   dependent: :destroy
  has_many :purchases, foreign_key: 'buyer_id',  class_name: 'Transaction'
  has_many :sales,     foreign_key: 'seller_id', class_name: 'Transaction'

  has_many :user_conversations, class_name: 'Conversation', foreign_key: 'user_id'
  has_many :messages
  has_many :comments

  has_many :locations, as: :locationable, dependent: :destroy
  accepts_nested_attributes_for :locations

  after_create :registration_gift

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

  def conversations
    Conversation.where("user_id = ? OR second_user_id = ?", id, id)
  end

  def allowed_messages
    cids = conversations.map(&:id)
    Message.where(conversation_id: cids)
  end

  def account_balance
    sales.sum(&:amount) - purchases.sum(&:amount)
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

  private

    def registration_gift
      Transaction.registration_gift(self)
    end
end