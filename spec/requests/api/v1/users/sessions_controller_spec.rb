require 'rails_helper'

RSpec.describe 'Users Controller, api::v1::userscontroller', type: :request do
  describe 'POST /sessions' do
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
