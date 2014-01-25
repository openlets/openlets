class Message < ActiveRecord::Base
  attr_accessible :text
  belongs_to :conversation
  belongs_to :user

  validates_presence_of :user_id, :text
end