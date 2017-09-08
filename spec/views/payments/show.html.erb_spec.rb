require 'rails_helper'

RSpec.describe "payments/show", type: :view do
  before(:each) do
    @payment = assign(:payment, Payment.create!(
      :paypal_email => "Paypal Email",
      :bank_routing_number => "Bank Routing Number",
      :bank_account_number => "Bank Account Number",
      :billing_name => "Billing Name",
      :billing_street_address => "Billing Street Address",
      :billing_city => "Billing City",
      :billing_state => "Billing State"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Paypal Email/)
    expect(rendered).to match(/Bank Routing Number/)
    expect(rendered).to match(/Bank Account Number/)
    expect(rendered).to match(/Billing Name/)
    expect(rendered).to match(/Billing Street Address/)
    expect(rendered).to match(/Billing City/)
    expect(rendered).to match(/Billing State/)
  end
end
