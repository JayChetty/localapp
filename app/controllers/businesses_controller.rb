class BusinessesController < ApplicationController

  before_action :authenticate_owner!, except: [:general_index]

  def general_index
    @businesses = Business.all.located
    @hash = Gmaps4rails.build_markers(@businesses) do |business, marker|
      # puts business
        marker.lat business.latitude
        marker.lng business.longitude
    end    
  end

  def index
    @businesses = current_owner.businesses
    @located = @businesses.located
    @hash = Gmaps4rails.build_markers(@located) do |business, marker|
      # puts business
        marker.lat business.latitude
        marker.lng business.longitude
    end
  end

  def edit
    @business = current_owner.businesses.find(params[:id])
  end

  def new
    @owner = current_owner
    @business = @owner.businesses.new
  end

  def create
    @owner = current_owner
    @business = @owner.businesses.build(business_params)
    if @business.save
      @owner.ownerships.create(business_id: @business.id)
      flash[:success] = "New Business Created"
      redirect_to businesses_path
    else
      flash[:error] = "Could not create business"
      redirect_to new_business_path
    end
  end

  def update
    @business = current_owner.businesses.find(params[:id])
    if @business.update_attributes(business_params)
      flash[:success] = "Business Updated"
      redirect_to edit_business_path(@business)
    else
      flash[:failure] = "Could not update Business"
      redirect_to edit_business_path(@business)
    end    
  end

  private
    def business_params
      params.require(:business).permit(:name, :address, :latitude, :longitude)
    end  

end
