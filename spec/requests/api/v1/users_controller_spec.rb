require 'rails_helper'

RSpec.describe 'Users Controller, api::v1::userscontroller', type: :request do
  let(:valid_headers) {
   {"CONTENT_TYPE" => "application/json"}
   {"Etag" => "f22061f294b256cf0e04fa4d150cee30"}
   {"Cache-Control" => "max-age=0, private, must-revalidate"}
   {"X-Request-id" => "aab43c90-7f82-4ec7-9101-6a22b6e341e4"}
   {"X-Runtime" => "0.095101"}
   {"Transfer-Encoding" => "chunked"}
 }

  describe 'POST /users' do
    describe 'happy path' do
      it 'can create a new user from an email, password, and password confirmation', :vcr do
        expect(User.count).to eq(0)
        post "/api/v1/users", params: {email: "klaud@test.com", password: "password", password_confirmation: "password"}, as: :json
        # require "pry"; binding.pry

        expect(User.count).to eq(1)
        response = JSON.parse(response.body, symbolize_names: true)
        expect(response).to be_successful
        expect(response).to be_a(Hash)
        expect(response[:data].keys.count).to eq(3)
        expect(response[:data][:type]).to eq("response")
        expect(response[:data][:attributes].count).to eq(2)
        expect(response[:data][:attributes].keys).to eq([:email, :api_key])
      end
    end

    describe 'sad path' do
      it 'does not create a user if there is no password' do
        post "/api/v1/users", params: {email: "klaud@test.com", password: "", password_confirmation: "password"}, as: :json
        expect(response.status).to eq(422)
      end

      it 'does not create a user if there is no password confirmation' do
        post "/api/v1/users", params: {email: "klaud@test.com", password: "password", password_confirmation: ""}, as: :json
        expect(response.status).to eq(422)
      end

      it 'does not create a user if passwords do not match' do
        post "/api/v1/users", params: {email: "klaud@test.com", password: "password", password_confirmation: "pword"}, as: :json
        expect(response.status).to eq(422)
      end

      it 'does not create a user if no email is entered' do
        post "/api/v1/users", params: {email: "", password: "password", password_confirmation: "password"}, as: :json
        expect(response.status).to eq(422)
      end

      it 'does not create a user if email already exists' do
        post "/api/v1/users", params: {email: "klaud@test.com", password: "password", password_confirmation: "password"}, as: :json
        post "/api/v1/users", params: {email: "klaud@test.com", password: "password", password_confirmation: "password"}, as: :json
        expect(response.status).to eq(422)
      end
    end
  end
end
