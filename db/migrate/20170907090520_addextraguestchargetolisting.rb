class Addextraguestchargetolisting < ActiveRecord::Migration[5.1]
  def change
  	add_column :listings, :extra_guest_charges, :integer
  	add_column :listings, :maximum_guest_allowed, :integer
  end
end
