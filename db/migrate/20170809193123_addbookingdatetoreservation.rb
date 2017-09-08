class Addbookingdatetoreservation < ActiveRecord::Migration[5.1]
  def change
  	add_column :reservations, :booking_date, :datetime
  end
end
