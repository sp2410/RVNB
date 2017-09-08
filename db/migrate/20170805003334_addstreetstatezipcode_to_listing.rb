class AddstreetstatezipcodeToListing < ActiveRecord::Migration[5.1]
  def change
  	add_column :listings, :street, :string
  	add_column :listings, :state, :string
  	add_column :listings, :zipcode, :string  	
  end
end
