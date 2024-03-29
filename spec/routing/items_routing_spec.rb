require "rails_helper"

RSpec.describe Api::V1::ItemsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "api/v1/items").to route_to("api/v1/items#index")
    end
  end
end
