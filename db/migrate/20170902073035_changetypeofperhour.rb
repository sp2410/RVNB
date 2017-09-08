class Changetypeofperhour < ActiveRecord::Migration[5.1]
	def change
	  	# def up
	    change_column :listings, :rentalminimum, :integer
		# end
		# def down
		# 	change_column :listings, :rentalminimum, :string
		# end
	end
end
