class Payment < ApplicationRecord

	validates_presence_of :billing_name
	validates_presence_of :billing_street_address
	validates_presence_of :billing_city
	validates_presence_of :billing_state

	validates_presence_of :contact_number
end
