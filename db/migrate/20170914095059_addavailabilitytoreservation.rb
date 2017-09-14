class Addavailabilitytoreservation < ActiveRecord::Migration[5.1]
  def change
  	add_reference :reservations, :availability, foreign_key: true
  end
end
