require 'rails_helper'

RSpec.describe "api/v1/users", type: :request do

  let(:valid_attributes) {
    ({ 
      email: "missday@newgirl.com",
      password: "ilovecrafts",
      password_confirmation: "ilovecrafts",
      first_name: "Jessica",
      last_name: "Day",
      role: "admin"
    })
  }

  let(:valid_attributes_2) {
    ({ 
      email: "nick@newgirl.com",
      password: "clydesbar",
      password_confirmation: "clydesbar",
      first_name: "Nick",
      last_name: "Miller"
    })
  }

  let(:invalid_attributes) {
    ({ 
      email: "winston@newgirl.com",
      password: "furguson",
      password_confirmation: "catz4lyfe",
      first_name: "Winston",
      last_name: "bishop"
    })
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response if an accurate api key is given" do
     admin = User.create! valid_attributes

      get "/api/v1/users?api_key=#{admin.api_key}"
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    
      body = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(body).to be_an Array
      expect(body.first).to have_key :id
      expect(body.first[:type]).to eq("user")
      
      user = body[0][:attributes]
      expect(user).to be_a Hash
      expect(user).to_not have_key :password_digest
      expect(user[:email]).to be_a String
      expect(user[:first_name]).to be_a String
      expect(user[:last_name]).to be_a String
    end

    it "renders an unsuccessful response if an inaccurate api key is given" do
     admin = User.create! valid_attributes

      get "/api/v1/users?api_key=fakeapikey"
      expect(response).to_not be_successful
      expect(response).to have_http_status(:unauthorized)
    
      body = JSON.parse(response.body, symbolize_names: true)[:data]
      
      expect(body).to be_a Hash
      expect(body[:error]).to eq("Invalid API key.")
    end

    it "renders an unsuccessful response if no api key is given" do
     admin = User.create! valid_attributes

      get "/api/v1/users"
      expect(response).to_not be_successful
      expect(response).to have_http_status(:unauthorized)
      
      body = JSON.parse(response.body, symbolize_names: true)[:data]
      
      expect(body).to be_a Hash
      expect(body[:error]).to eq("Invalid API key.")
      
      get "/api/v1/users?api_key="
      expect(response).to_not be_successful
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      user = User.create! valid_attributes
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
      expect(user[:api_key]).to be_a String
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
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the user" do
        user = User.create! valid_attributes
        patch api_v1_user_url(user),
              params: { user: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))

        body = JSON.parse(response.body, symbolize_names: true)[:data]
        expect(body).to be_a Hash
        expect(body).to have_key(:error)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested user with accurate API key" do
      admin = User.create! valid_attributes
      user = User.create! valid_attributes_2
      expect {
        delete "/api/v1/users/#{user.id}?api_key=#{admin.api_key}"
      }.to change(User, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
    
    it "renders an error if an api key is not provided to destroy a user" do
      admin = User.create! valid_attributes
      user = User.create! valid_attributes_2
      expect {
        delete "/api/v1/users/#{user.id}"
      }.to change(User, :count).by(0)
      expect(response).to_not be_successful
      expect(response).to have_http_status(:unauthorized)
    
      body = JSON.parse(response.body, symbolize_names: true)[:data]
      
      expect(body).to be_a Hash
      expect(body[:error]).to eq("Invalid API key.")

      delete "/api/v1/users/#{user.id}?api_key="
      expect(response).to_not be_successful
      expect(response).to have_http_status(:unauthorized)
    end

    it "renders an error if an incorrect api key is provided to destroy a user" do
      admin = User.create! valid_attributes
      user = User.create! valid_attributes_2
      expect {
        delete "/api/v1/users/#{user.id}?api_key=fakeapikey"
      }.to change(User, :count).by(0)
      expect(response).to_not be_successful
      expect(response).to have_http_status(:unauthorized)
    
      body = JSON.parse(response.body, symbolize_names: true)[:data]
      
      expect(body).to be_a Hash
      expect(body[:error]).to eq("Invalid API key.")
    end
  end
end
