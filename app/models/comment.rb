class Comment < ActiveRecord::Base
  attr_accessible :commentable_id, :commentable_type, :content, :user_id
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates_presence_of :content, :user_id

end