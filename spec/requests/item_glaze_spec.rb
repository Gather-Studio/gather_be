require 'rails_helper'

RSpec.describe "/api/v1/item_glazes", type: :request do
  let(:user) {
      User.create!({ 
      email: "missday@newgirl.com",
      password: "ilovecrafts",
      password_confirmation: "ilovecrafts",
      first_name: "Jessica",
      last_name: "Day"
    })
  }

  let(:item) {
    Item.create!({
      name: "Vase", 
      status: 0, 
      clay_body: "Brown Speckle",
      height: 10.0, 
      width: 4.5, 
      memo: "It's a little wonky", 
      style: "Wheel-Thrown",
      user_id: user.id
    })
  }

  let(:glaze) {
    Glaze.create!({
      name: "Rainforest",
      brand: "Amaco"
    })
  }

  let(:valid_attributes) {
    {item_id: item.id,
     glaze_id: glaze.id,
     layers: 3}
  }

  let(:invalid_attributes) {
    {item_id: item.id+1,
     glaze_id: glaze.id,
     layers: nil}
  }

  let(:valid_headers) {
    {}
  }

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Item Glaze relationship" do
        expect {
          post api_v1_item_glazes_url,
               params: { item_glaze: valid_attributes }, headers: valid_headers, as: :json
        }.to change(ItemGlaze, :count).by(1)
      end

      it "renders a JSON response with the new glaze" do
        post api_v1_item_glazes_url,
               params: { item_glaze: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Glaze" do
        expect {
          post api_v1_item_glazes_url,
               params: { item_glaze: invalid_attributes }, as: :json
        }.to change(ItemGlaze, :count).by(0)
      end

      it "renders a JSON response with errors for the new glaze" do
          post api_v1_item_glazes_url,
               params: { item_glaze: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        ({ layers: 2})
      }

      it "updates the requested glaze" do
        item_glaze = ItemGlaze.create! valid_attributes
        patch api_v1_item_glaze_url(item_glaze),
              params: { item_glaze: new_attributes }, headers: valid_headers, as: :json
        expect(item_glaze.layers).to eq(3)
        item_glaze.reload
        expect(item_glaze.layers).to eq(2)
      end

      it "renders a JSON response with the glaze" do
        item_glaze = ItemGlaze.create! valid_attributes
        patch api_v1_item_glaze_url(item_glaze),
              params: { item_glaze: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the glaze" do
        item_glaze = ItemGlaze.create! valid_attributes
        patch api_v1_item_glaze_url(item_glaze),
              params: { item_glaze: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested glaze" do
      item_glaze = ItemGlaze.create! valid_attributes
      expect {
        delete api_v1_item_glaze_url(item_glaze), headers: valid_headers, as: :json
      }.to change(ItemGlaze, :count).by(-1)
    end
  end
end
