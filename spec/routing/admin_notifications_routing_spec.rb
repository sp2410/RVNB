require "rails_helper"

RSpec.describe AdminNotificationsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin_notifications").to route_to("admin_notifications#index")
    end

    it "routes to #new" do
      expect(:get => "/admin_notifications/new").to route_to("admin_notifications#new")
    end

    it "routes to #show" do
      expect(:get => "/admin_notifications/1").to route_to("admin_notifications#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin_notifications/1/edit").to route_to("admin_notifications#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin_notifications").to route_to("admin_notifications#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin_notifications/1").to route_to("admin_notifications#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin_notifications/1").to route_to("admin_notifications#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin_notifications/1").to route_to("admin_notifications#destroy", :id => "1")
    end

  end
end
