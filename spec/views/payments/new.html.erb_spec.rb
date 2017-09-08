require 'rails_helper'

RSpec.describe "payments/new", type: :view do
  before(:each) do
    assign(:payment, Payment.new(
      :paypal_email => "MyString",
      :bank_routing_number => "MyString",
      :bank_account_number => "MyString",
      :billing_name => "MyString",
      :billing_street_address => "MyString",
      :billing_city => "MyString",
      :billing_state => "MyString"
    ))
  end

  it "renders new payment form" do
    render

    assert_select "form[action=?][method=?]", payments_path, "post" do

      assert_select "input[name=?]", "payment[paypal_email]"

      assert_select "input[name=?]", "payment[bank_routing_number]"

      assert_select "input[name=?]", "payment[bank_account_number]"

      assert_select "input[name=?]", "payment[billing_name]"

      assert_select "input[name=?]", "payment[billing_street_address]"

      assert_select "input[name=?]", "payment[billing_city]"

      assert_select "input[name=?]", "payment[billing_state]"
    end
  end
end
