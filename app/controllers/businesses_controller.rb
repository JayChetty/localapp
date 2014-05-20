class BusinessesController < ApplicationController

  before_action :authenticate_owner!, except: [:general_index, :index, :show]

  # def general_index
  #   @businesses = Business.all.located

  #   @geojson = Array.new

  #   @businesses.each do |business|
  #     @geojson << {
  #       type: 'Feature',
  #       geometry: {
  #         type: 'Point',
  #         coordinates: [business.longitude, business.latitude]
  #       },
  #       properties: {
  #       name: business.name,
  #       address: business.address,
  #       :'marker-color' => '#00607d',
  #       :'marker-symbol' => 'circle',
  #       :'marker-size' => 'medium'
  #       }     
  #     }
  #   end

  #   respond_to do |format|
  #     format.html
  #     format.json { render json: @geojson }  # respond with the created JSON object
  #   end    
  # end

  def index
    @businesses = Business.all
    # @business = current_owner.businesses.first
    # redirect_to edit_business_path(@business)

    # @located = @businesses.located
    # @hash = Gmaps4rails.build_markers(@located) do |business, marker|
    #   # puts business
    #     marker.lat business.latitude
    #     marker.lng business.longitude
    # end
    respond_to do |format|
      format.html
      format.json { render json: @businesses }  # respond with the created JSON object
    end        
  end

  # def edit_my_business
  #   business = current_owner.business.

  # end

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
