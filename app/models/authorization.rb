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
    binding.pry
    graph = Koala::Facebook::API.new(self.token)
    facebook_data = graph.get_object("me")
    if facebook_data['username']
      self.user.username ||= facebook_data['username']
      if self.user.image.blank?
        image_url = "http://graph.facebook.com/" + facebook_data['username'] + "/picture?type=large&redirect=false"
        result = Net::HTTP.get(URI.parse(image_url))
        self.user.remote_image_url = JSON.parse(result)["data"]["url"]
      end
    end
    self.user.location ||= facebook_data['location']
    self.save
		self.user.save
	end

	def fetch_details_from_linkedin

	end

	def fetch_details_from_google_oauth2

	end

end
