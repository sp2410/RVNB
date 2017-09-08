class Deletecolumnfromreservation < ActiveRecord::Migration[5.1]
  def change
  	remove_column :reservations, :startdate
  	remove_column :reservations, :enddate
  	remove_column :reservations, :needcaptain
  	
  end
end
