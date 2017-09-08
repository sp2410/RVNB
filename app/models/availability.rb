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

    	p "goao!\n"

    	if availability.reservations.present?
	    	availability.reservations.each do |i|	    			
	    		if (i.booking_date == date) and (i.status == "approved")
	    			
	    			return true
	    		end
	    	end
	    end

    	return false

    end


end
