class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.string :paypal_email
      t.string :bank_account_number
      t.string :bank_routing_number      
      t.string :billing_name
      t.string :billing_street_address
      t.string :billing_city
      t.string :billing_state
      t.timestamps
    end
  end
end
