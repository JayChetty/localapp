class BusinessesController < ApplicationController

  def index
    @businesses = Business.all
    puts "IN"
    @hash = Gmaps4rails.build_markers(@businesses) do |business, marker|
      # puts business
      marker.lat business.latitude
      marker.lng business.longitude
    end
  end

end
