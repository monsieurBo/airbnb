class Listing < ApplicationRecord
  belongs_to :user
  has_many :users, through: :reservations
  has_many :reservations

  mount_uploaders :avatars, AvatarUploader
  scope :countries, -> { select(:country).order(:country) }
  scope :cities, -> { select(:city).order(:city)}

  def self.search(search)
  	where("country ILIKE ? OR city ILIKE ?", "%#{search}%", "%#{search}%")
  end
end
