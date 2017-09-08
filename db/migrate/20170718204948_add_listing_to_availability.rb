class AddListingToAvailability < ActiveRecord::Migration[5.1]
  def change
  	add_reference :availabilities, :listing, foreign_key: true
  end
end
