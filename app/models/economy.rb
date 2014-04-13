class Economy < ActiveRecord::Base
  attr_accessible :currency_name, :description, :economy_type, :title, :currency_type, :domain
  validates_presence_of :title, :economy_type, :currency_name, :currency_type, :domain

  has_many :members
  has_many :categories
  has_many :users, through: :members
  has_many :wallets
end
