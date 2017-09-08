class AddstarttimeandEndTimeToReservation < ActiveRecord::Migration[5.1]
  def change
  	add_column :reservations, :start_time, :datetime
  	add_column :reservations, :end_time, :datetime
  	add_column :reservations, :total_cost, :float
  end
end
