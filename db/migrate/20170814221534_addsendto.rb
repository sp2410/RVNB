class Addsendto < ActiveRecord::Migration[5.1]

  def self.up
  	add_column :notifications, :send_to, :string

  end

  def self.down
  	remove_column :notifications, :send_to, :string

  end

end
