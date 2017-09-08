json.extract! payment, :id, :paypal_email, :bank_routing_number, :bank_account_number, :billing_name, :billing_street_address, :billing_city, :billing_state, :created_at, :updated_at
json.url payment_url(payment, format: :json)
