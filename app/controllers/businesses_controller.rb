class BusinessesController < ApplicationController

  before_action :authenticate_owner!, except: [:general_index, :index, :show]


  def index
    if current_owner && current_owner.admin
      @businesses = Business.all
    else
      @businesses = Business.where(verified: true)
    end
    if current_owner   
      current_business = current_owner.businesses.first
      if current_business && !current_business.verified
        @businesses << current_business
      end
      @businesses.each do |b|
        b.has_current_owner = (b == current_business)
      end
    end
    respond_to do |format|
      format.html
      format.json { 
        render json: @businesses.to_json(methods: [:has_current_owner, :owner_name])
      }
    end        
  end

  def verify
    if current_owner.admin
      business = Business.find(params[:id])
      business.verified = true
      if business.save
        head :ok
      else
        raise 'problem'
      end
    else
      raise 'not admin'
    end
  end


  # def edit
  #   @business = current_owner.businesses.find(params[:id])  
  # end

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
    @business.update_attributes(business_params)
    respond_to do |format|
      format.html
      format.json { render json: @businesses.to_json(methods: :has_current_owner) }
    end      
    # if @business.update_attributes(business_params)
    #   flash[:success] = "Business Updated"
    #   redirect_to edit_business_path(@business)
    # else
    #   flash[:failure] = "Could not update Business"
    #   redirect_to edit_business_path(@business)
    # end    
  end

  private
    def business_params
      params.require(:business).permit(:name, :address, :latitude, :longitude, :description, :license, :hot_drinks, :food, :url, :phone_number)
    end  

end
