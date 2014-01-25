class Conversation < ActiveRecord::Base
  attr_accessible :second_user_id, :user_id, :messages_attributes, :text

  belongs_to :user
  belongs_to :second_user, class_name: 'User', foreign_key: 'second_user_id'
  
  has_many :messages, dependent: :destroy
  accepts_nested_attributes_for :messages

  validates_presence_of   :user_id, scope: :second_user_id
  validates_uniqueness_of :user_id, scope: :second_user_id

  validate :not_with_myself

  def other_user(me)
    me == user ? second_user : user
  end

  private

    def not_with_myself
      errors.add :base, "cant talk with yourself" if user_id == second_user_id
    end

end