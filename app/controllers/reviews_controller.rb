class ReviewsController < InheritedResources::Base

before_action :set_parents, only: [:show, :edit, :update, :destroy]
before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

include ApplicationHelper

 
  # GET /listings/new
  def new
    @listing = Listing.find_by_id(params[:listing_id])
    @availability = Availability.find_by_id(params[:availability_id])
    @reservation = Reservation.find_by_id(params[:reservation_id])
    @review = Review.new
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = Listing.find_by_id(params[:listing_id])
    @availability = Availability.find_by_id(params[:availability_id])
    @reservation = Reservation.find_by_id(params[:reservation_id])    
    @review = Review.new review_params.merge! reservation_id: params[:reservation_id]
    @review.reviewerid = current_user.id
          
    respond_to do |format|
      if @review.save

        @reservation.reviwed = true
        @reservation.save

        reviewer_email = current_user.email

        owner_email = User.find_by_id(@listing.user_id).email
        
        format.html { redirect_to @listing, notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @review }

        @adminnotification = AdminNotification.new message: "Hi! Renter left a review for #{@listing.vehicletype}, id number #{@listing.id}, review by #{reviewer_email}, reservation id: #{@reservation.id}. Please review and release #{@reservation.total_cost} dollars to #{owner_email}"
        @adminnotification.save!
        
        send_email(@listing, "RVNB: A review was submitted by renter","Hi! Renter left a review for #{@listing.vehicletype}, id number #{@listing.id}, review by #{reviewer_email}, reservation id: #{@reservation.id}. Please review and release #{@reservation.total_cost} dollars to #{owner_email}", ["thedealerschoice@yahoo.com"])        
        

      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @listing, notice: 'Review was updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      @reservation.reviwed = false
      @reservation.save
      format.html { redirect_to listings_url, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

 

  private

    def set_parents
      @listing = Listing.find_by_id(params[:listing_id])
      @availability = Availability.find_by_id(params[:availability_id])
      @reservation = Reservation.find_by_id(params[:reservation_id])
      @review = Review.find_by_id(params[:id])
    end

    def review_params
      params.require(:review).permit(:accuracy, :communication, :cleanliness, :checkin, :owners_behaviour, :valueformoney, :reviewerid, :comment)
    end
end

