require 'rails_helper'

RSpec.describe "/api/v1/items", type: :request do

    let(:user1) {
    User.create!({ 
      email: "missday@newgirl.com",
      password: "ilovecrafts",
      password_confirmation: "ilovecrafts",
      first_name: "Jessica",
      last_name: "Day"
    })
  }
    let(:user2) {
    User.create!({ 
      email: "nick@newgirl.com",
      password: "clydesbar",
      password_confirmation: "clydesbar",
      first_name: "Nick",
      last_name: "Miller"
    })
  }

  let(:valid_attributes1) {
    ({
      name: "Vase", 
      status: 0, 
      clay_body: "Brown Speckle",
      height: 10.0, 
      width: 4.5, 
      memo: "It's a little wonky", 
      style: "Wheel-Thrown",
      user_id: user1.id
    })
  }

  let(:valid_attributes2) {
    ({
name: "Spoon", 
      status: 0, 
      clay_body: "Red Clay", 
      height: 10.0, 
      width: 4.5, 
      memo: "Gift for Nan", 
      style: "Hand Built",
      user_id: user2.id
    })
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      Item.create! valid_attributes1
      Item.create! valid_attributes2
      get api_v1_items_url, headers: valid_headers, as: :json
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(body).to be_an Array
      expect(body.count).to eq 2
      expect(body.first).to have_key :id
      expect(body.first[:type]).to eq("item")
      
      item = body[0][:attributes]
      expect(item).to be_a Hash
      expect(item).to have_key :name
      expect(item).to have_key :status
      expect(item).to have_key :style
      expect(item).to have_key :clay_body
      expect(item).to have_key :item_glazes
      expect(item[:item_glazes]).to be_an Array
      expect(item).to have_key :height
      expect(item).to have_key :width
      expect(item).to have_key :memo
    end
  end
end 