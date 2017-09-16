ActiveAdmin.register Reservation do


	scope :requested
    scope :approved
    scope :billed
    scope :paid
    scope :onhold
    scope :viewall



controller do 

    def send_email_with_reservation_details(reservation, subject, message, user)
      from = 'sales@tdcdigitalmedia.com'          
      content = "<html><head><style type='text/css'>body,html,.body{background:#D3D3D3!important;}</style></head><body><container><spacer size='16'></spacer><row><columns><center><img class='small-float-center' width='500px' height='300px' src=#{Listing.find_by_id(reservation.listing_id).imagefront}></center></columns></row><row><columns large='8'><center><h2>RVNB</h2></center></columns></row><row><columns large='6'><center><h4>Hi! Its RVNB team!</h4><br><p>#{message}</p><br><p>Follow: https://rvnb.herokuapp.com/listings/#{reservation.listing_id} to view</p><center></columns><columns large='6'><br><p>Phone: +1 866-338-7870 Line 5</p><br><p>Email:sales@tdcdigitalmedia.com</p></columns><columns large='4'><img class='small-float-center' width='100px' height='100px' src='//s3-us-west-2.amazonaws.com/rvnb/rvnblogo.jpg' alt=''></columns></row><row></row></container><body></html>"
      notifier = EmailNotifier.new(from, user, subject, content)
      notifier.send
    end

     def getpayment(user)
      @payment = Payment.where('user_id = ?', user.id).first
      @payment == nil ? false : @payment        
    end

    def send_text(send_to, message)
      @notifier = Twilionotifier.new
      @notifier.notify_through_text(send_to, message)
    end
   

    def get_owners_contact(reservation)
        user = get_reservation_listing_owner(reservation)        
        getpayment(user) == false ? get_reservation_listing_owner(reservation).email : getpayment(user)
    end

    def get_pickup_address(reservation)
        owner = get_reservation_listing(reservation)
        address = owner.pickup_street_address + "\n" + owner.pickup_city + ", " + owner.pickup_state + ", " + owner.pickup_zipcode
    end
        

     def get_reservation_listing_owner(reservation)
        user = User.find_by_id(Listing.find_by_id(reservation.listing_id).user_id)
        return user
    end

     def get_reservation_listing(reservation)
        @listing = Listing.find_by_id(reservation.listing_id)
        return @listing
    end


end



permit_params :start_time, :end_time, :numberofguests, :booking_date, :total_cost, :status

member_action :markasrequested, method: :get do
    resource.set_default_role

    if resource.save!        
    	redirect_to admin_reservations_path, notice: "Status marked as Requested!"        
    else
    	redirect_to admin_reservations_path, notice: "Error while changing status!'"
    end

end


member_action :markasbilled, method: :get do
    resource.set_as_billed

    if resource.save!
    	redirect_to admin_reservations_path, notice: "Status marked as billed!"
        @user = User.find_by_id(resource.user_id)        
        @notification = Notification.new send_to: "#{@user.email}" , message: "Hi! The reservation id number #{resource.id} for #{resource.booking_date} was accepted. We have sent you an invoice, please check you email inbox"
        @notification.save!        

        send_email_with_reservation_details(resource, "RVNB: Reservation payment invoice sent", "RVNB: Hi! The reservation id number #{resource.id} for #{resource.booking_date} was accepted. We have sent you an invoice, please check your email inbox for the email id you used to login", ["#{@user.email}"])        
        if (getpayment(@user) == true)
            send_text(getpayment(@user).contact_number, "RVNB: Hi! The reservation id number #{resource.id} for #{resource.booking_date} was accepted. We have sent you an invoice, please check your email inbox for the email id you used to login")
        end
    else
    	redirect_to admin_reservations_path, notice: "Error while changing status!'"
    end

end


member_action :markaspaid , method: :get do
    resource.set_as_paid
    if resource.save!
    	redirect_to admin_reservations_path, notice: "Status marked as paid!"
        @user = User.find_by_id(resource.user_id)        
        @notification = Notification.new send_to: "#{@user.email}" , message: "Hi! The payment on reservation id #{resource.id} for #{resource.booking_date} was accepted. Here are the owner details: Here are the owner and pickup details: Contact: #{get_owners_contact(resource)} \n #{get_pickup_address(resource)}"
        @notification.save!        

        @owner_notification = Notification.new send_to: "#{get_reservation_listing_owner(resource).email}" , message: "Hi! The payment on reservation id #{resource.id} for #{resource.booking_date} was accepted. We have made your contact informations available to #{@user.email}. Please get in touch or wait from the renter to contact you"
        @owner_notification.save!

        send_email_with_reservation_details(resource, "RVNB: Your payment was accepted", "Hi! The payment on reservation id #{resource.id} for #{resource.booking_date} was accepted. We have made your contact informations available to #{@user.email}. Please get in touch or wait from the renter to contact you", ["#{get_reservation_listing_owner(resource).email}"])        
        send_email_with_reservation_details(resource, "RVNB: Your payment was accepted", "Hi! The payment on reservation id #{resource.id} for #{resource.booking_date} was accepted. Here are the owner and pickup details: Contact: #{get_owners_contact(resource)} \n #{get_pickup_address(resource)}", ["#{@user.email}"])        

        if (getpayment(@user) == true)
            p "here"
            send_text(getpayment(@user).contact_number, "RVNB: Hi! The payment on reservation id #{resource.id} for #{resource.booking_date} was accepted. Here are the owner and pickup details: Contact: #{get_owners_contact(resource)} \n #{get_pickup_address(resource)}")
        end

    else
    	redirect_to admin_reservations_path, notice: "Error while changing status!'"
    end
end



member_action :markasonhold, method: :get do
    resource.set_as_onhold

   if resource.save!
    	redirect_to admin_reservations_path, notice: "Status marked as onhold"
        @user = User.find_by_id(resource.user_id)        
        @notification = Notification.new send_to: "#{@user.email}" , message: "Hi!The reservation id number #{resource.id} for #{resource.booking_date} has been put on hold, please contact us to resolve the situation"
        @notification.save!       

        send_email_with_reservation_details(resource, "RVNB: Reservation is on hold", "The reservation id number #{resource.id} for #{resource.booking_date} has been put on hold, please contact us to resolve the situation", ["#{@user.email}"])         

        if (getpayment(@user) == true)

            send_text(getpayment(@user).contact_number, "The reservation id number #{resource.id} for #{resource.booking_date} has been put on hold, please contact us to resolve the situation")
        end
    else
    	redirect_to admin_reservations_path, notice: "Error while changing status!'"
    end
end

member_action :askforreview, method: :get do

    @reserver = User.find_by_id(resource.user_id)
    
    #send an email
        @notification = Notification.new send_to: "#{@reserver.email}" , message: "Hi!We Hope you enjoyed the reservation id number #{resource.id} for #{resource.booking_date}. For us you are a very important customer and we would request your reviews for the trip. Please go to the listing page and submit a review. We will release money to the owner only when you are satisfied."

        if @notification.save! 
            send_email_with_reservation_details(resource, "RVNB: Need reviews for your last trip. Owner is waiting for your reviews", "We hope you enjoyed the reservation id number #{resource.id} for #{resource.booking_date}. For us you are a very important customer and we would request your reviews for the trip. Please go to the listing page and submit a review. We will release money to the owner only when you are satisfied and had a great experience. We will judge it from your ratings", ["#{@reserver.email}"])         
            redirect_to admin_reservations_path, notice: "Email for review has been sent"

            if (getpayment(@reserver) == true)
                send_text(getpayment(@reserver).contact_number, "We hope you enjoyed the reservation id number #{resource.id} for #{resource.booking_date}. For us you are a very important customer and we would request your reviews for the trip. Please go to the listing page and submit a review. We will release money to the owner only when you are satisfied and had a great experience. We will judge it from your ratings")
            end
        else
            redirect_to admin_reservations_path, notice: "Oops! Error while changing sending review request, please call the renter and ask for reviews"            
            # redirect_to admin_reservations_path, notice: "Error while sending email"
        end

end



index do 
	column :id
	column "Booking Date", :booking_date
	column "Total Cost", :total_cost
	column "Start Time", :start_time
	column "End Time", :end_time
	column "Number of Guests", :numberofguests
	column "User id", :user_id
	column "Availability Id", :availability_id



	column "" do |resource|
      links = ''.html_safe
      links += link_to I18n.t('active_admin.edit'), edit_resource_path(resource), :class => "member_link edit_link"
      links += link_to I18n.t('active_admin.view'), resource_path(resource), :class => "member_link view_link"
      links += link_to I18n.t('active_admin.delete'), resource_path(resource), :method => :delete, :confirm => I18n.t('active_admin.delete_confirmation'), :class => "member_link delete_link"
      links
    end
    column "Status", :status 

    column "Invoice sent?" do |reservations|
    	link_to "Yes, Mark as Billed", markasbilled_admin_reservation_path(reservations)
    end
    column "Payment Received?" do |reservations|
    	link_to "Yes, Mark as Paid", markaspaid_admin_reservation_path(reservations)
    end
    column "Put on Hold?" do |reservations|
    	link_to "Yes, Put on hold", markasonhold_admin_reservation_path(reservations)
    end

    column "Mark as just Requested?" do |reservations|
    	link_to "Yes, Go back and mark as Requestd", markasrequested_admin_reservation_path(reservations)
    end

    column "Reviewed", :reviwed

    column "Ask Reserver for reviews?" do |reservations|
        link_to "Yes, Send Email", askforreview_admin_reservation_path(reservations)
    end

end

end
