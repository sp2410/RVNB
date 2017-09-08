class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :accuracy
      t.string :communication
      t.string :cleanliness      
      t.string :checkin
      t.string :owners_behaviour
      t.string :valueformoney
      t.string :reviewerid
      t.string :comment

      t.timestamps
    end
  end
end
