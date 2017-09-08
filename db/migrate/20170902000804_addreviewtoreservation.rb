class Addreviewtoreservation < ActiveRecord::Migration[5.1]
  def change
  	
  	add_reference :reviews, :reservation, foreign_key: true  	
  end

  # def self.down
  # 	remove_reference :reviews, :reservation, foreign_key: true 
  # end
  # end
end
