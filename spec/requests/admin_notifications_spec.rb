require 'rails_helper'

RSpec.describe "AdminNotifications", type: :request do
  describe "GET /admin_notifications" do
    it "works! (now write some real specs)" do
      get admin_notifications_path
      expect(response).to have_http_status(200)
    end
  end
end
