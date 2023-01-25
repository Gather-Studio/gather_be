require "rails_helper"

RSpec.describe Api::V1::ItemGlazesController, type: :routing do
  describe "routing" do

    it "routes to #create" do
      expect(post: "/api/v1/item_glazes").to route_to("api/v1/item_glazes#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/api/v1/item_glazes/1").to route_to("api/v1/item_glazes#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/api/v1/item_glazes/1").to route_to("api/v1/item_glazes#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/api/v1/item_glazes/1").to route_to("api/v1/item_glazes#destroy", id: "1")
    end
  end
end
