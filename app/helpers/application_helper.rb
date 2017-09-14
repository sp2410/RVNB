require 'emailnotifier'
require 'twilionotifier'

module ApplicationHelper

	def set_notification
	    if user_signed_in?
	      Notification.where(:send_to => current_user.email).count
	    end
  	end

  	def getuser(id)
  		@reviweuser = User.find_by_id(id)
  		return @reviweuser
  	end


  	def allowreviews(reservation)

  		if user_signed_in?
  			p "user if signed in"
  			if reservation.user_id == current_user.id
  				p "user is reserver"
  				if reservation.status == "paid" 
  					p "user has paid"
					  if Date.today > reservation.booking_date
					  	p "date is greater"

		  				if !reservation.reviwed
		  					p "reservation not reviewed yet"
		  					return true
		  				end
		  			end
	  			end
  			end
  		end

  		return false
      # return true

  	end

    def sortable(column, title = nil)
      title ||= column.titleize
      css_class = column == sort_column ? "current #{sort_direction}" : nil
      direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"      
      # link_to title, request.params.merge({:sort => column, :direction => direction, :page => nil}), {:class => "css_class" }
      link_to title, params.permit(:min, :max, :radius, :startdate, :near).merge({:sort => column, :direction => direction, :page => nil}), {:class => "css_class" }
    end

    def getpayment(user)
      @payment = Payment.where('user_id = ?', current_user.id).first
      @payment == nil ? false : @payment        
    end

        

    def myreservationslistings(user)
      myreservations = Reservation.where('user_id = ?', user.id)
      p "reservation"
      myreservations.empty? ? false : Listing.where(id: myreservations.pluck(:listing_id))      
    end



    def getreservations(listing)
      reservations = Reservation.where(:listing_id => listing.id).where(:user_id => current_user.id)
      reservations.empty? ? false : reservations      
    end


    def send_email(product, subject, message, user)
      from = 'sales@tdcdigitalmedia.com'          
      content = "<html><head><style type='text/css'>body,html,.body{background:#D3D3D3!important;}</style></head><body><container><spacer size='16'></spacer><row><columns><center><img src=#{product.imagefront}></center></columns></row><row><columns large='8'><center><h2>RVNB</h2></center></columns></row><row><columns large='6'><center><h4>Hi! Its RVNB team!</h4><br><p>#{message}</p><br><p>Follow: http://www.rvnb.com/listings/#{product.id} to view</p><center></columns><columns large='6'><br><p>Phone: +1 866-338-7870 Line 5</p><br><p>Email:sales@tdcdigitalmedia.com</p></columns><columns large='4'><img class='small-float-center' width='100px' height='100px' src='https://s3-us-west-2.amazonaws.com/rvnb/logo4.svg' alt=''></columns></row><row></row></container><body></html>"
      @notifier = EmailNotifier.new(from, user, subject, content)
      @notifier.send
    end


     def send_email_with_reservation_details(reservation, subject, message, user)
      from = 'sales@tdcdigitalmedia.com'          
      content = "<html><head><style type='text/css'>body,html,.body{background:#D3D3D3!important;}</style></head><body><container><spacer size='16'></spacer><row><columns><center><img src=#{Listing.find_by_id(reservation.listing_id).imagefront}></center></columns></row><row><columns large='8'><center><h2>RVNB</h2></center></columns></row><row><columns large='6'><center><h4>Hi! Its RVNB team!</h4><br><p>#{message}</p><br><p>Follow: http://www.rvnb.com/listings/#{reservation.listing_id} to view</p><center></columns><columns large='6'><br><p>Phone: +1 866-338-7870 Line 5</p><br><p>Email:sales@tdcdigitalmedia.com</p></columns><columns large='4'><img class='small-float-center' width='100px' height='100px' src='//s3-us-west-2.amazonaws.com/rvnb/logo4.svg' alt=''></columns></row><row></row></container><body></html>"
      @notifier = EmailNotifier.new(from, user, subject, content)
      @notifier.send
    end


    def send_text(send_to, message)
      @notifier = Twilionotifier.new
      @notifier.notify_through_text(send_to, message)
    end


    def user_is_listing_owner(listing)
      if user_signed_in?
        if listing.user_id == current_user.id
            return true
        end
      end

      return false
    end

end

