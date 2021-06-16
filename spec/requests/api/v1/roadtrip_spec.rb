require 'rails_helper'

RSpec.describe 'Roadtrip Controller, api::v1::roadtripcontroller', type: :request do
  describe 'Getting information from this API' do
    describe 'Happy path' do
      it 'can POST a roadtrip and return weather and travel time', :vcr do
        @user = User.create(email: 'klaudia@test.com', password: 'password', password_confirmation: 'password')
        @user.update(api_key: SecureRandom.hex)
        post "/api/v1/road_trip", params: {origin: 'denver,co', destination: 'ouray,co', api_key: @user.api_key}

        expect(response).to be_successful
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body).to be_a(Hash)
        expect(body[:data].count).to eq(3)
        expect(body[:data].keys).to eq([:id, :type, :attributes])
        expect(body[:data][:id]).to eq(nil)
        expect(body[:data][:type]).to eq('roadtrip')
        expect(body[:data][:attributes].count).to eq(4)
        expect(body[:data][:attributes].keys).to eq([:start_city, :end_city, :travel_time, :weather_at_eta])

        expect(body[:data][:attributes][:start_city]).to be_a(String)
        expect(body[:data][:attributes][:end_city]).to be_a(String)
        expect(body[:data][:attributes][:travel_time]).to be_a(String)
        expect(body[:data][:attributes][:weather_at_eta]).to be_a(Hash)

        expect(body[:data][:attributes][:weather_at_eta].count).to eq(2)
        expect(body[:data][:attributes][:weather_at_eta].keys).to eq([:temperature, :description])
        expect(body[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Integer)
        expect(body[:data][:attributes][:weather_at_eta][:description]).to be_a(String)
      end
    end

    describe 'sad path' do
      it 'does not create a trip if api_token is not there', :vcr do
        @user = User.create(email: 'klaudia@test.com', password: 'password', password_confirmation: 'password')
        @user.update(api_key: SecureRandom.hex)
        post "/api/v1/road_trip", params: {origin: 'denver,co', destination: 'ouray,co', api_key: ''}

        body = JSON.parse(response.body, symbolize_names: true)
        expect(response.status).to eq(401)
        expect(body[:error]).to eq("Unauthorized")
      end

      it 'does not create a trip if api_token is not an exisiting key', :vcr do
        @user = User.create(email: 'klaudia@test.com', password: 'password', password_confirmation: 'password')
        @user.update(api_key: SecureRandom.hex)
        post "/api/v1/road_trip", params: {origin: 'denver,co', destination: 'ouray,co', api_key: 'erayersfdgsW154647fd'}

        body = JSON.parse(response.body, symbolize_names: true)
        expect(response.status).to eq(401)
        expect(body[:error]).to eq("Unauthorized")
      end

      it 'does not create a trip if origin and/or destination are not present', :vcr do
        @user = User.create(email: 'klaudia@test.com', password: 'password', password_confirmation: 'password')
        @user.update(api_key: SecureRandom.hex)
        post "/api/v1/road_trip", params: {origin: '', destination: '', api_key: @user.api_key}

        body = JSON.parse(response.body, symbolize_names: true)
        expect(response.status).to eq(400)
        expect(body[:error]).to eq("Missing or bad params")
      end

      it 'does not create a trip if origin to destination is an impossible route', :vcr do
        @user = User.create(email: 'klaudia@test.com', password: 'password', password_confirmation: 'password')
        @user.update(api_key: SecureRandom.hex)
        post "/api/v1/road_trip", params: {origin: 'denver,co', destination: 'london,uk', api_key: @user.api_key}

        body = JSON.parse(response.body, symbolize_names: true)
        expect(response.status).to eq(400)
        expect(body[:error]).to eq("Impossible route")
      end
    end
  end
end
