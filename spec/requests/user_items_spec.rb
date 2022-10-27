require 'rails_helper'

RSpec.describe "api/v1/users/:user_id/items", type: :request do

  let(:user) {
    User.create!({ 
      email: "missday@newgirl.com",
      password: "ilovecrafts",
      password_confirmation: "ilovecrafts",
      first_name: "Jessica",
      last_name: "Day"
    })
  }

  let(:valid_attributes) {
    ({
      name: "Vase",
      status: 0,
      user_id: user.id
    })
  }

  let(:invalid_attributes) {
    ({
      user_id: 1999
    })
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      user.items.create! valid_attributes
      get api_v1_user_items_url(user), headers: valid_headers, as: :json
      
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(body).to be_an Array
      expect(body.first).to have_key :id
      expect(body.first[:type]).to eq("item")
      
      item = body[0][:attributes]
      expect(item).to be_a Hash
      expect(item).to have_key :name
      expect(item).to have_key :status
      expect(item).to have_key :style
      expect(item).to have_key :clay_body
      expect(item).to have_key :glazes
      expect(item).to have_key :height
      expect(item).to have_key :width
      expect(item).to have_key :memo
      expect(item).to have_key :user
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      item = user.items.create! valid_attributes
      get api_v1_user_item_url(user, item), as: :json
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(body).to be_a Hash
      expect(body).to have_key :id
      expect(body[:type]).to eq("item")

      item = body[:attributes]
      expect(item).to be_a Hash
      expect(item).to have_key :name
      expect(item).to have_key :status
      expect(item).to have_key :style
      expect(item).to have_key :clay_body
      expect(item).to have_key :glazes
      expect(item).to have_key :height
      expect(item).to have_key :width
      expect(item).to have_key :memo
      expect(item).to have_key :user
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Item" do
        expect {
          post api_v1_user_items_url(user),
               params: { item: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Item, :count).by(1)
      end

      it "renders a JSON response with the new item" do
        post api_v1_user_items_url(user),
             params: { item: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))

        body = JSON.parse(response.body, symbolize_names: true)[:data]  
        expect(body).to be_a Hash
        expect(body).to have_key :id
        expect(body[:type]).to eq("item")
  
        item = body[:attributes]
        expect(item).to be_a Hash
        expect(item).to have_key :name
        expect(item).to have_key :status
        expect(item).to have_key :style
        expect(item).to have_key :clay_body
        expect(item).to have_key :glazes
        expect(item).to have_key :height
        expect(item).to have_key :width
        expect(item).to have_key :memo
        expect(item).to have_key :user
      end
    end

    context "with invalid parameters" do
      it "does not create a new Item" do
        expect {
          post api_v1_user_items_url(user),
               params: { item: invalid_attributes }, as: :json
        }.to change(Item, :count).by(0)
      end

      it "renders a JSON response with errors for the new item" do
        post api_v1_user_items_url(user),
             params: { item: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))

        body = JSON.parse(response.body, symbolize_names: true)[:data]
        expect(body).to be_a Hash
        expect(body).to have_key(:error)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        ({ name: "Vase for Mum"})
      }

      it "updates the requested item" do
        item = user.items.create! valid_attributes
        patch api_v1_user_item_url(user, item),
              params: { item: new_attributes }, headers: valid_headers, as: :json
        expect(item.name).to eq("Vase")
        item.reload
        expect(item.name).to eq("Vase for Mum")
      end

      it "renders a JSON response with the item" do
        item = user.items.create! valid_attributes
        patch api_v1_user_item_url(user, item),
              params: { item: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))

        body = JSON.parse(response.body, symbolize_names: true)[:data]  
        expect(body).to be_a Hash
        expect(body).to have_key :id
        expect(body[:type]).to eq("item")
  
        item = body[:attributes]
        expect(item).to be_a Hash
        expect(item).to have_key :name
        expect(item).to have_key :status
        expect(item).to have_key :style
        expect(item).to have_key :clay_body
        expect(item).to have_key :glazes
        expect(item).to have_key :height
        expect(item).to have_key :width
        expect(item).to have_key :memo
        expect(item).to have_key :user
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the item" do
        item = user.items.create! valid_attributes
        patch api_v1_user_item_url(user, item),
              params: { item: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested item" do
      item = user.items.create! valid_attributes
      expect {
        delete api_v1_user_item_url(user, item), headers: valid_headers, as: :json
      }.to change(Item, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
