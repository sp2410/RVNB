require 'rails_helper'

RSpec.describe "admin_notifications/show", type: :view do
  before(:each) do
    @admin_notification = assign(:admin_notification, AdminNotification.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
