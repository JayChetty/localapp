class Business < ActiveRecord::Base
  attr_accessor :has_current_owner
  has_many :ownerships
  has_many :owners, through: :ownerships
  geocoded_by :address
  after_validation :geocode#, if: ->(obj){ obj.address.present? and obj.address_changed? }
  scope :verified, where(verified: true)

  # scope :located, where("longitude IS NOT NULL AND latitude IS NOT NULL")

  # def self

  # def self.located
  #   scoped.where("longitude IS NOT NULL AND latitude IS NOT NULL")
  # end

end
