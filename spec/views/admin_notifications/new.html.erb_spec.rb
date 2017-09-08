require 'rails_helper'

RSpec.describe "admin_notifications/new", type: :view do
  before(:each) do
    assign(:admin_notification, AdminNotification.new())
  end

  it "renders new admin_notification form" do
    render

    assert_select "form[action=?][method=?]", admin_notifications_path, "post" do
    end
  end
end
