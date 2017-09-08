require 'rails_helper'

RSpec.describe "admin_notifications/index", type: :view do
  before(:each) do
    assign(:admin_notifications, [
      AdminNotification.create!(),
      AdminNotification.create!()
    ])
  end

  it "renders a list of admin_notifications" do
    render
  end
end
