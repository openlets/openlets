class Location < ActiveRecord::Base
  attr_accessible :address, :city, :country, :ip, :latitude, :locationable_id, :locationable_type, :longitude
  belongs_to :locationable, polymorphic: true
end