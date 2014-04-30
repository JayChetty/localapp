class Business < ActiveRecord::Base
  has_many :ownerships
  has_many :owners, through: :ownerships
  geocoded_by :address
  after_validation :geocode#, if: ->(obj){ obj.address.present? and obj.address_changed? }

  # scope :located, where("longitude IS NOT NULL AND latitude IS NOT NULL")

  def self.located
    scoped.where("longitude IS NOT NULL AND latitude IS NOT NULL")
  end  
end
