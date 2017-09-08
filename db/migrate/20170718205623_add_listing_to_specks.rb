class AddListingToSpecks < ActiveRecord::Migration[5.1]
  def change
  	add_reference :specks, :listing, foreign_key: true
  end
end
