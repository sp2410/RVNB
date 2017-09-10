class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy, :approvereservation]
  before_action :set_parents, only: [:new, :approvereservation, :create, :update, :destroy]
  
  before_action :authenticate_user!

  include ApplicationHelper


  # GET /reservations/new
  def new        
    @reservation = Reservation.new    
  end

  # GET /reservations/1/edit
  def edit
  end

  def approvereservation    

    @reservation.mark_as_approved

     respond_to do |format|
      if @reservation.save!
        format.html { redirect_to @listing, notice: 'Reservation was approved. We will connect you once we receive payments' }
        format.json { render :show, status: :ok, location: @listing }
        @reservationowner = User.find_by_id(@reservation.user_id)

        @notification = Notification.new send_to: "#{@reservationowner.email}" , message: "Hi! Your reservation on #{@listing.vehicletype}, id number #{@listing.id} for #{@reservation.booking_date} was accepted by the owner. Our team wil send the invoice for payment on your email shortly"
        @notification.save!

        @adminnotification = AdminNotification.new message: "Hi! Owner accepted the reservation on this #{@listing.vehicletype}, id number #{@listing.id}, reservation by #{@reservationowner.email}. Please review and send invoice for payment of #{@reservation.total_cost} and 10 percent to #{@reservationowner.email}"
        @adminnotification.save!

        send_email(@listing, "RVNB: Reservation Approved", "Hi! Your reservation on #{@listing.vehicletype}, id number #{@listing.id} for #{@reservation.booking_date} was accepted by the owner. Our team wil send the invoice for payment on your email shortly", ["#{@reservationowner.email}"])
        send_email(@listing, "RVNB: Send the invoice for payment, Reservation Id: #{@reservation.id} Approved", "Hi! Owner accepted the reservation on this #{@listing.vehicletype}, id number #{@listing.id}, reservation by #{@reservationowner.email}. Please review and send invoice for payment of #{@reservation.total_cost} and 10 percent to #{@reservationowner.email}", ["thedealerschoice@yahoo.com"])

        if getpayment(@reservationowner)
          send_text(getpayment(@reservationowner).contact_number, "Hi! Your reservation on #{@listing.vehicletype}, id number #{@listing.id} for #{@reservation.booking_date} was accepted by the owner. Our team wil send the invoice for payment on your email shortly")
        end
        

      else
        format.html { render :edit }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end

  end


 

  # POST /reservations
  # POST /reservations.json
  def create      
    @reservation = Reservation.new reservation_params.merge! availability_id: params[:availability_id]
    @reservation.user_id = current_user.id
    @reservation.listing_id = @listing.id
    @reservation.set_default_role

    respond_to do |format|
      if @reservation.save!
        format.html { redirect_to @listing, notice: 'Reservation was successfully created. Please Wait for the owner to approve first! Meanwhile please update the phone number in profile section to recieve real time text notfications for change of status' }
        format.json { render :show, status: :created, location: @reservation }

        #notifications
        @listingowner = User.find_by_id(@listing.user_id)

        p @listingowner.email

        @notification = Notification.new send_to: "#{@listingowner.email}" , message: "Hi! A new reservation was made on your #{@listing.vehicletype}, id number #{@listing.id}. Please review"
        @notification.save!

        send_email(@listing, "RVNB: Reservation Created on your #{@listing.vehicletype}", "Hi! A new reservation was made on your #{@listing.vehicletype}, id number #{@listing.id} title: #{@listing.title if @listing.title}. Please go to #{@listing.vehicletype} page to review", ["#{@listingowner.email}"])

        if getpayment(@listingowner)
          send_text(getpayment(@listingowner).contact_number, "Hi! A new reservation was made on your #{@listing.vehicletype}, id number #{@listing.id} title: #{@listing.title if @listing.title}. Please go to #{@listing.vehicletype} page to review")
        end
        
      else
        format.html { render :new }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to @reservation, notice: 'Reservation was successfully updated.' }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy    
    @reservationowner = User.find_by_id(@reservation.user_id)

    @reservation.destroy

    respond_to do |format|
      format.html { redirect_to @listing, notice: 'Reservation was successfully destroyed.' }
      format.json { head :no_content }

      @notification = Notification.new send_to: "#{@reservationowner.email}" , message: "Hi! We are very sorry, your reservation on #{@listing.vehicletype} id #{@listing.id} was destroyed. Please choose another #{@listing.vehicletype}"      
      @notification.save!

      send_email(@listing, "RVNB: Reservation Destroyed", "Hi! We are sorry. Your reservation on #{@listing.vehicletype}, id number #{@listing.id} for #{@reservation.booking_date} was destroyed. Please choose another #{@listing.vehicletype}", ["#{@reservationowner.email}"])

      if getpayment(@reservationowner)
        send_text(getpayment(@reservationowner).contact_number, "Hi! We are sorry. Your reservation on #{@listing.vehicletype}, id number #{@listing.id} for #{@reservation.booking_date} was destroyed. Please choose another #{@listing.vehicletype}")
      end        

    end
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    def set_parents
      @listing = Listing.find_by_id(params[:listing_id])
      @availability = Availability.find_by_id(params[:availability_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:start_time, :end_time, :numberofguests, :booking_date, :total_cost)
    end
    
end



