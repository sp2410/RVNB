class AddListingToReservation < ActiveRecord::Migration[5.1]
  def change
  	add_reference :reservations, :listing, foreign_key: true
  end
end
