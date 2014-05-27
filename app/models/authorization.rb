class Authorization < ActiveRecord::Base
	belongs_to :user

	after_create :fetch_details

	PROVIDERS = %w(facebook linkedin google_oauth2)
	PROVIDERS.each do |provider|
    scope provider.to_sym, lambda { where(provider: provider) }
  end

  def fetch_details
    self.send("fetch_details_from_#{self.provider.downcase}")
  end

	def fetch_details_from_facebook
    graph = Koala::Facebook::API.new(self.token)
    facebook_data = graph.get_object("me")
		self.username = facebook_data['username']
		self.save
		self.user.username = facebook_data['username'] if self.user.username.blank?
		self.user.remote_image_url = "http://graph.facebook.com/" + self.username + "/picture?type=large" if self.user.image.blank?
		self.user.location = facebook_data['location'] if self.user.location.blank?
		self.user.save
	end

	def fetch_details_from_linkedin

	end

	def fetch_details_from_google_oauth2

	end

end
