class ChangeDateFormatInMyTable < ActiveRecord::Migration[5.1]
   def up
    change_column :reservations, :booking_date, :date
    change_column :reservations, :start_time, :time
    change_column :reservations, :end_time, :time
  end

  def down
    change_column :reservations, :booking_date, :datetime
    change_column :reservations, :start_time, :datetime
    change_column :reservations, :end_time, :datetime
  end
end

