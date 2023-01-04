require "rails_helper"

RSpec.describe Api::V1::SessionsController, type: :routing do
  describe "routing" do
    it "routes to #create" do
      expect(post: "api/v1/sessions").to route_to("api/v1/sessions#create")
    end
  end 
end 