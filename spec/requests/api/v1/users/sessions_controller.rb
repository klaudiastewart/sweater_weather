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

  describe 'POST /sessions' do
    before(:each) do

    end

    describe 'happy path' do
      it 'can create a new session for a user', :vcr do
        @user = User.create(email: 'klaudia@test.com', password: 'password', password_confirmation: 'password')
        @user.update(api_key: SecureRandom.hex)
        post "/api/v1/sessions", params: {email: 'klaudia@test.com', password: 'password'}
        json_response = JSON.parse(response.body, symbolize_names: true)

        expect(json_response.class).to eq(Hash)
        expect(json_response.keys).to eq([:data])
        expect(json_response[:data].count).to eq(3)
        expect(json_response[:data].keys).to eq([:id, :type, :attributes])
        expect(json_response[:data][:attributes].count).to eq(2)
        expect(json_response[:data][:attributes].keys).to eq([:email, :api_key])
      end
    end

    describe 'sad path' do
      it 'does not create a user session if user info is wrong' do
        @user = User.create(email: 'klaudia@test.com', password: 'password', password_confirmation: 'password')
        @user.update(api_key: SecureRandom.hex)
        post "/api/v1/sessions", params: {email: 'klaw@test.com', password: 'password'}
        json_response = JSON.parse(response.body, symbolize_names: true)

        expect(json_response[:status]).to eq(401)
        expect(json_response[:error]).to eq("No authorization")
      end

      it 'does not create a user session if passwords do not match' do
        @user = User.create(email: 'klaudia@test.com', password: 'password', password_confirmation: 'password')
        @user.update(api_key: SecureRandom.hex)
        post "/api/v1/sessions", params: {email: 'klaudia@test.com', password: 'pword'}
        json_response = JSON.parse(response.body, symbolize_names: true)

        expect(json_response[:status]).to eq(401)
        expect(json_response[:error]).to eq("No authorization")
      end 
    end
  end
end
