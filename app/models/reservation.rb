class Reservation < ApplicationRecord
	belongs_to :availability
    has_many :reviews,  dependent: :destroy 

 
    scope :viewall, -> { }
    scope :requested, -> { where(:status => "requested")}
    scope :approved, -> {where(:status => "approved")}
    scope :billed, -> {where(:status => "billed")}
    scope :paid, -> {where(:status => "paid")}
    scope :onhold, ->{where(:status => "onhold")}

	
	enum status: {:requested => 'requested', :approved => 'approved', :billed => 'billed', :paid => 'paid', :onhold  => 'onhold'}
  
  

  		def set_default_role
    		self.status = :requested
    		# return true
		end

		def mark_as_approved
    		self.status = :approved 
    		p "approved"
    		# return true   		
		end

		def set_as_billed
    		self.status = :billed
    		p "billed"
    		# return true
		end

		def set_as_paid
    		self.status = :paid
    		p "paid"
    		# return true
		end

		def set_as_onhold
    		self.status = :onhold
    		p "onhold"
    		# return true
		end

end
