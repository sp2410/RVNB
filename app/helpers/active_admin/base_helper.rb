require 'emailnotifier'

module ActiveAdmin::BaseHelper #camelized file name
	
   # def send_email_with_reservation_details(reservation, subject, message, user)
   #    from = 'sales@tdcdigitalmedia.com'          
   #    content = "<html><head><style type='text/css'>body,html,.body{background:#D3D3D3!important;}</style></head><body><container><spacer size='16'></spacer><row><columns><center><img src=#{Listing.find_by_id(reservation.listing_id).imagefront}></center></columns></row><row><columns large='8'><center><h2>RVNB</h2></center></columns></row><row><columns large='6'><center><h4>Hi! Its RVNB team!</h4><br><p>#{message}</p><br><p>Follow: http://www.rvnb.com/listings/#{reservation.listing_id} to view</p><center></columns><columns large='6'><br><p>Phone: +1 866-338-7870 Line 5</p><br><p>Email:sales@tdcdigitalmedia.com</p></columns><columns large='4'><img class='small-float-center' width='100px' height='100px' src='https://s3-us-west-2.amazonaws.com/wacbacassetsdonttouch/wacbacassets/TDC.png' alt=''></columns></row><row></row></container><body></html>"
   #    @notifier = EmailNotifier.new(from, user, subject, content)
   #    @notifier.send
   #  end

end 