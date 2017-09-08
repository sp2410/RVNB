require 'rails_helper'

RSpec.describe "admin_notifications/edit", type: :view do
  before(:each) do
    @admin_notification = assign(:admin_notification, AdminNotification.create!())
  end

  it "renders the edit admin_notification form" do
    render

    assert_select "form[action=?][method=?]", admin_notification_path(@admin_notification), "post" do
    end
  end
end
