class User < ApplicationRecord
  include Clearance::User
  mount_uploader :avatar, AvatarUploader
  has_many :authentications, dependent: :destroy
  has_many :listings
  has_many :reservations
  has_many :listings, through: :reservations

  enum role: [ :customer, :superadmin, :moderator]

	def self.create_with_auth_and_hash(authentication, auth_hash)
		user = self.create!(
		first_name: auth_hash["info"]["first_name"],
		last_name: auth_hash["info"]["last_name"],
		email: auth_hash["info"]["email"],
    password: SecureRandom.hex(10)
		)
		user.authentications << authentication
		return user
	end

	# grab google to access google for user data
	def google_token
		x = self.authentications.find_by(provider: 'google_oauth2')
		return x.token unless x.nil?
	end

end
