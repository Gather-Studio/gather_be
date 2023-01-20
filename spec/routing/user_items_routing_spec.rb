require "rails_helper"

RSpec.describe Api::V1::UserItemsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "api/v1/users/1/items").to route_to("api/v1/user_items#index", user_id: "1")
    end

    it "routes to #show" do
      expect(get: "api/v1/users/1/items/1").to route_to("api/v1/user_items#show", id: "1", user_id: "1")
    end


    it "routes to #create" do
      expect(post: "api/v1/users/1/items").to route_to("api/v1/user_items#create", user_id: "1")
    end

    it "routes to #update via PUT" do
      expect(put: "api/v1/users/1/items/1").to route_to("api/v1/user_items#update", id: "1", user_id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "api/v1/users/1/items/1").to route_to("api/v1/user_items#update", id: "1", user_id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "api/v1/users/1/items/1").to route_to("api/v1/user_items#destroy", id: "1", user_id: "1")
    end
  end
end
