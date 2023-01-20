require 'rails_helper'

RSpec.describe "/api/v1/glazes", type: :request do

  let(:valid_attributes) {
    ({name: "Rainforest",
    brand: "Amaco"})
  }

  let(:invalid_attributes) {
    ({name: nil})
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      Glaze.create! valid_attributes
      get api_v1_glazes_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      glaze = Glaze.create! valid_attributes
      get api_v1_glaze_url(glaze), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Glaze" do
        expect {
          post api_v1_glazes_url,
               params: { glaze: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Glaze, :count).by(1)
      end

      it "renders a JSON response with the new glaze" do
        post api_v1_glazes_url,
             params: { glaze: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Glaze" do
        expect {
          post api_v1_glazes_url,
               params: { glaze: invalid_attributes }, as: :json
        }.to change(Glaze, :count).by(0)
      end

      it "renders a JSON response with errors for the new glaze" do
        post api_v1_glazes_url,
             params: { glaze: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        ({ brand: "Mayco"})
      }

      it "updates the requested glaze" do
        glaze = Glaze.create! valid_attributes
        patch api_v1_glaze_url(glaze),
              params: { glaze: new_attributes }, headers: valid_headers, as: :json
        expect(glaze.brand).to eq("Amaco")
        glaze.reload
        expect(glaze.brand).to eq("Mayco")
      end

      it "renders a JSON response with the glaze" do
        glaze = Glaze.create! valid_attributes
        patch api_v1_glaze_url(glaze),
              params: { glaze: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the glaze" do
        glaze = Glaze.create! valid_attributes
        patch api_v1_glaze_url(glaze),
              params: { glaze: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested glaze" do
      glaze = Glaze.create! valid_attributes
      expect {
        delete api_v1_glaze_url(glaze), headers: valid_headers, as: :json
      }.to change(Glaze, :count).by(-1)
    end
  end
end
