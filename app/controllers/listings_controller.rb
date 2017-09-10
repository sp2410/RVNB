class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  helper_method :sort_column, :sort_direction

  include ApplicationHelper


  # GET /listings
  # GET /listings.json
  def index
    # @listings = Listing.all
    if params.present?            
      @listingssearch =  Listing.search(params)        
      
        # flash[:notice] = "Please see listings below"
            
    else
      @listingssearch =  Listing.all      
    end
    
    #for ransack you use rails activerecord query methods on the result from ransack i.e. @search.result
    @listingsboats = @listingssearch.where(:vehicletype => 'Boat').order(sort_column + " " + sort_direction)
    # .paginate(:page => params[:page], :per_page => 100)

    # @listingsrvs = Listing.search(params)
    @listingsrvs = @listingssearch.where(:vehicletype => 'RV').order(sort_column + " " + sort_direction)
    # .paginate(:page => params[:page], :per_page => 100)


    # .page(params[:page]).per_page(4)    
  end



  # GET /listings/1
  # GET /listings/1.json
  def show
    @listingspecks = @listing.specks    
    @listingavailabilities = @listing.availabilities    
    @listinguser = User.find_by_id(@listing.user_id)
    @reviewuser_id = 1000000000000000000
  end

  # GET /listings/new
  def new
    @listing = Listing.new
    flash[:notice] = "Step 1: Please fill in the form below and click submit to proceed "
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = Listing.new(listing_params)
    @listing.user_id = current_user.id

    respond_to do |format|
      if @listing.save

        # format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
        format.html { redirect_to new_listing_availability_path(@listing), notice: 'Step 2: Listing was successfully created. Please add atleast one availability duration.' }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def mylistings    
    @listingsboats = Listing.where(:vehicletype => 'Boat').where('user_id = ?', current_user.id).paginate(:page => params[:page], :per_page => 30)
    @listingsrvs = Listing.where(:vehicletype => 'RV').where('user_id = ?', current_user.id).paginate(:page => params[:page], :per_page => 30)
  end

  def myreservations
    # p Listing.myreservationslistings(current_user)
    if myreservationslistings(current_user)
      @listingsboats = myreservationslistings(current_user).where(:vehicletype => 'Boat').paginate(:page => params[:page], :per_page => 30)
      @listingsrvs = myreservationslistings(current_user).where(:vehicletype => 'RV').paginate(:page => params[:page], :per_page => 30)
    else
      @listingsboats = Listing.where('id = ?', 109129009120).paginate(:page => params[:page], :per_page => 30)
      @listingsrvs  = @listingsboats
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:title, :description, :year, :length, :sleeps, :rateperhour, :vehicletype, :rentalminimum, :latitude, :longitude, :city, :imagefront, :imageback, :imageleft, :imageright, :interiorfront, :interiorback, :state, :zipcode, :pickup_street_address, :pickup_city, :pickup_state, :pickup_zipcode, :extra_guest_charges, :maximum_guest_allowed)
    end

    def sort_column
      p params[:sort]
      p "hello polo"
      Listing.column_names.include?(params[:sort]) ? params[:sort] : "rateperhour"
      # p params[:sort]
      # p "check params"
       # %w[:direction, :max, :min, :near, :radius , :sort, :startdate, :direction,].include?(params) ? params[:sort] : "rateperhour"
      #  params.present? params[:sort] : "rateperhour"
      #  if params[:sort].present?
      #   params[:sort]
      # else
      #   "rateperhour"
      # end
      
    end

    def sort_direction
      # p params[:direction]
      # p "hello golo"
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    



end
