class CreateListings < ActiveRecord::Migration[5.1]
  def change
    create_table :listings do |t|
      t.string :title
      t.string :description
      t.string :year
      t.integer :length
      t.integer :sleeps
      t.integer :rateperhour
      t.string :vehicletype
      t.integer :rentalminimum
      t.float :latitude
      t.float :longitude
      t.string :city
      t.string :imagefront
      t.string :imageback
      t.string :imageleft
      t.string :imageright
      t.string :interiorfront
      t.string :interiorback

      t.timestamps
    end
  end
end
