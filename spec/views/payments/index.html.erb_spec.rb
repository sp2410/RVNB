require 'rails_helper'

RSpec.describe "payments/index", type: :view do
  before(:each) do
    assign(:payments, [
      Payment.create!(
        :paypal_email => "Paypal Email",
        :bank_routing_number => "Bank Routing Number",
        :bank_account_number => "Bank Account Number",
        :billing_name => "Billing Name",
        :billing_street_address => "Billing Street Address",
        :billing_city => "Billing City",
        :billing_state => "Billing State"
      ),
      Payment.create!(
        :paypal_email => "Paypal Email",
        :bank_routing_number => "Bank Routing Number",
        :bank_account_number => "Bank Account Number",
        :billing_name => "Billing Name",
        :billing_street_address => "Billing Street Address",
        :billing_city => "Billing City",
        :billing_state => "Billing State"
      )
    ])
  end

  it "renders a list of payments" do
    render
    assert_select "tr>td", :text => "Paypal Email".to_s, :count => 2
    assert_select "tr>td", :text => "Bank Routing Number".to_s, :count => 2
    assert_select "tr>td", :text => "Bank Account Number".to_s, :count => 2
    assert_select "tr>td", :text => "Billing Name".to_s, :count => 2
    assert_select "tr>td", :text => "Billing Street Address".to_s, :count => 2
    assert_select "tr>td", :text => "Billing City".to_s, :count => 2
    assert_select "tr>td", :text => "Billing State".to_s, :count => 2
  end
end
