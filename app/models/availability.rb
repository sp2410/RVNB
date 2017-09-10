class Availability < ApplicationRecord
	belongs_to :listing  	
	has_many :reservations

	def start_time
        self.startdate ##Where 'start' is a attribute of type 'Date' accessible through MyModel's relationship
    end

    def end_time
        self.enddate ##Where 'start' is a attribute of type 'Date' accessible through MyModel's relationship
    end

    def self.isunavilable(availability, date)

    	p "is_unavailable!\n"

    	if availability.reservations.present?
	    	availability.reservations.each do |i|	    			
	    		if (Availability.reservation_booking_date(i) == date) and (Availability.reservation_status(i) == "approved")	    			
                    p "booked!\n"
	    			return true
                    
	    		end
	    	end
	    end

    	return false

    end


	private 
	
    #Dependency management: Availability should not depend on reservation, neither know about it

    def self.reservation_booking_date(reservation)
    	reservation.booking_date
    end

    def self.reservation_status(reservation)
    	reservation.status
    end


end
