class Adduserreference < ActiveRecord::Migration[5.1]
  def self.up
  	add_reference :listings, :user, foreign_key: true, index: { name: 'original_user' }	
  	add_reference :reservations, :user, foreign_key: true
  end

  def self.down
  	remove_reference :listings, :user, foreign_key: true, index: { name: 'original_user' }	
  	remove_reference :reservations, :user, foreign_key: true
  end
end
