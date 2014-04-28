class Business < ActiveRecord::Base
  has_many :ownerships
  has_many :owners, through: :ownerships
end
