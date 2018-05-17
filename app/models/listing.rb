class Listing < ApplicationRecord
	include PgSearch
  belongs_to :user
  has_many :users, through: :reservations
  has_many :reservations, :dependent => :destroy

  enum place_type: [ :entire_place, :private_room, :share_room]

  mount_uploaders :avatars, AvatarUploader
  scope :countries, -> { select(:country).order(:country) }
  scope :cities, -> { select(:city).order(:city)}
  pg_search_scope :search, :against => [:country]

  def self.search_country(search)
  	# where("country ILIKE  :country OR city ILIKE :city", country: "%#{search}%", city: "%#{search}%")
    # where("country ILIKE :country", country: "%#{search}%")
    where("country ILIKE :country", country: "%#{search}%").map do |record|
      record.country
    #   p record.country
    end
  end

  def self.search(search)
    # where("country ILIKE  :country OR city ILIKE :city", country: "%#{search}%", city: "%#{search}%")
    where("country ILIKE :country", country: "%#{search}%")
    # where("country ILIKE :country", country: "%#{search}%").map do |record|
      # record.country
    #   p record.country
    # end
  end
end
