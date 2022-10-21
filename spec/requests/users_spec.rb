require 'rails_helper'

RSpec.describe "/users", type: :request do

  let(:valid_attributes) {
    ({ 
      email: "missday@newgirl.com",
      password: "ilovecrafts",
      password_confirmation: "ilovecrafts",
      first_name: "Jessica",
      last_name: "Day"
    })
  }

  let(:invalid_attributes) {
    ({ 
      email: "winston@newgirl.com",
      password: "cats",
      password_confirmation: "ilovecats",
      first_name: "Winston",
      last_name: "bishop"
    })
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      User.create! valid_attributes
      get api_v1_users_url, headers: valid_headers, as: :json

      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    
      body = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(body).to be_an Array
      expect(body.first).to have_key :id
      expect(body.first[:type]).to eq("users")
      
      user = body[0][:attributes]
      expect(user).to be_a Hash
      expect(user).to_not have_key :password_digest
      expect(user[:email]).to be_a String
      expect(user[:first_name]).to be_a String
      expect(user[:last_name]).to be_a String
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      user = User.create! valid_attributes
      item = user.items.create!(name: "Knit Sweater", status: 0)
      get api_v1_user_url(user), as: :json
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(body).to be_a Hash
      expect(body).to have_key :id
      expect(body[:type]).to eq("user")

      user = body[:attributes]
      expect(user).to_not have_key :password_digest
      expect(user[:email]).to be_a String
      expect(user[:first_name]).to be_a String
      expect(user[:last_name]).to be_a String
      expect(user[:items]).to be_an Array

      item = user[:items].first
      expect(item).to have_key :id
      expect(item).to have_key :name
      expect(item).to have_key :status
      expect(item).to have_key :clay_body
      expect(item).to have_key :glazes
      expect(item).to have_key :height
      expect(item).to have_key :width
      expect(item).to have_key :memo
      expect(item).to have_key :user_id
      expect(item).to have_key :created_at
      expect(item).to have_key :updated_at
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new User" do
        expect {
          post api_v1_users_url,
               params: { user: valid_attributes }, headers: valid_headers, as: :json
        }.to change(User, :count).by(1)
      end

      it "renders a JSON response with the new user" do
        post api_v1_users_url,
             params: { user: valid_attributes }, headers: valid_headers, as: :json
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
        expect(user[:items]).to be_an Array
      end
    end

    context "with invalid parameters" do
      it "does not create a new User" do
        expect {
          post api_v1_users_url,
               params: { user: invalid_attributes }, as: :json
        }.to change(User, :count).by(0)
      end

      it "renders a JSON response with errors for the new user" do
        post api_v1_users_url,
             params: { user: invalid_attributes }, headers: valid_headers, as: :json
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
        ({
          first_name: "Jess"
        })
      }

      let(:password_attributes) {
        ({
          password: "iloveteaching",
          password_confirmation: "iloveteaching"
        })
      }
      let(:invalid_attributes) {
        ({
          password: "iloveknitting",
          password_confirmation: "iloveteaching"
        })
      }

      it "updates the requested user" do
        user = User.create! valid_attributes
        patch api_v1_user_url(user),
              params: { user: password_attributes }, headers: valid_headers, as: :json
        
        old_password = user.password_digest
        user.reload
        expect(user.password_digest).to_not eq(old_password)
      end

      it "updates the requested user's password" do
        user = User.create! valid_attributes
        patch api_v1_user_url(user),
              params: { user: new_attributes }, headers: valid_headers, as: :json
        
        expect(user.first_name).to eq("Jessica")
        user.reload
        expect(user.first_name).to eq("Jess")
      end

      it "renders a JSON response with the user" do
        user = User.create! valid_attributes
        patch api_v1_user_url(user),
              params: { user: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
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
        expect(user[:items]).to be_an Array
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the user" do
        user = User.create! valid_attributes
        patch api_v1_user_url(user),
              params: { user: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested user" do
      user = User.create! valid_attributes
      expect {
        delete api_v1_user_url(user), headers: valid_headers, as: :json
      }.to change(User, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
