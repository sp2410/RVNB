class Listing < ApplicationRecord

	mount_uploader :imagefront, ImageUploader
	mount_uploader :imageback, ImageUploader
	mount_uploader :imageleft, ImageUploader
	mount_uploader :imageright, ImageUploader

	mount_uploader :interiorfront, ImageUploader
	mount_uploader :interiorback, ImageUploader

	validates_presence_of :title
	validates_presence_of :description
	validates_presence_of :rentalminimum
	validates_presence_of :rateperhour

	validates_presence_of :imagefront

	validates_presence_of :pickup_street_address
	validates_presence_of :pickup_city
	validates_presence_of :pickup_state
	validates_presence_of :pickup_zipcode

	validates_presence_of :extra_guest_charges
	validates_presence_of :maximum_guest_allowed


	# accepts_nested_attributes_for :pictures, :allow_destroy => true

	
	geocoded_by :city
	after_validation :geocode

	has_many :specks,  dependent: :destroy 
	has_many :availabilities,  dependent: :destroy 

	

	def self.search(params)

		products = Listing.all
		
		if params.present?

			if params[:startdate].present?
				date = params[:startdate]
				p "hey its date"
				listingsids = Availability.where('startdate <= ?', date).where('enddate >= ?', date).pluck('listing_id')
				products = Listing.where(id: listingsids)
				# products = Listing.joins(:availabilities).where('availability.startdate <= ?', date).where('availability.enddate >= ?', date)
			end
			
			if params[:near].present?
				near = params[:near]
				p "hello"
				if params[:radius].present?
					p products
					products = products.near(near, params[:radius])
					p "hello 1"
					
				else
					products  = products.near(near)
					p "hello near"
					
				end

				if params[:min].present?
					p products
					p "hello 2"
					 products = products.where("rateperhour >= ?", params[:min].to_i)
					 
				end

				if params[:max].present?
					p products
					p "hello 3"
					 products = products.where("rateperhour <= ?", params[:max].to_i)
					 p products
				end
								
			end
			
				# products
		end

			products		
	end


end
