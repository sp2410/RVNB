class Addcontactumbertopayment < ActiveRecord::Migration[5.1]
  def change
  	add_column :payments, :contact_number, :string
  end
end
