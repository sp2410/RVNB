class AddPickuploactiontolisting < ActiveRecord::Migration[5.1]
  def change
  	add_column :listings, :pickup_street_address, :string
  	add_column :listings, :pickup_city, :string
  	add_column :listings, :pickup_state, :string
  	add_column :listings, :pickup_zipcode, :string
  end
end
