require 'rails_helper'

RSpec.describe "api/v1/sessions", type: :request do
  
  let(:user_information) {
    ({
      email: "nickmiller@newgirl.com",
      password: "thegriffin",
      password_confirmation: "thegriffin",
      first_name: "Nick",
      last_name: "Miller"
    })
  }

  let(:valid_attributes) {
    ({
      email: "nickmilLer@newgirl.com",
      password: "thegriffin"
    })
  }

   let(:invalid_attributes) {
    ({ 
      email: "nickmiller@newgirl.com",
      password: "jessicaday"
    })
  }

  let(:valid_headers) {
    {}
  }


  describe "POST /create" do
    context "with valid parameters" do
      it "creates an new session and renders a JSON response with the user's information" do 
        user = User.create! user_information

        post api_v1_sessions_url, params: valid_attributes , headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
        body = JSON.parse(response.body, symbolize_names: true)[:data]
        
        expect(body).to be_a Hash
        expect(body).to have_key :id
        expect(body[:type]).to eq("user")

        user = body[:attributes]
        expect(user).to_not have_key :password_digest
        expect(user[:email]).to be_a String
        expect(user[:first_name]).to be_a String
        expect(user[:last_name]).to be_a String
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors if the information is incorrect" do
        user = User.create! user_information
        post api_v1_sessions_url, params: invalid_attributes , headers: valid_headers, as: :json
        expect(response).to have_http_status(:bad_request)
        expect(response.content_type).to match(a_string_including("application/json"))

        body = JSON.parse(response.body, symbolize_names: true)[:data]
        expect(body).to be_a Hash
        expect(body).to have_key(:error)
        expect(body[:error]).to eq("Those credentials are incorrect. Try again!")
      end
    end
  end
end