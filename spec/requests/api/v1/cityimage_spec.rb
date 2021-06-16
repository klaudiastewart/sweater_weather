require 'rails_helper'

RSpec.describe 'City Image Controller, api::v1::cityimagecontroller', type: :request do
  describe 'GET /backgrounds' do
    describe 'happy path' do
      it 'can get a description, image url, source, and author of a city photo', :vcr do
        get "/api/v1/backgrounds", params: {location: "denver,co"}
        image = JSON.parse(response.body, symbolize_names: true)
        expect(response).to be_successful
        expect(image).to be_a(Hash)
        expect(image[:data].count).to eq(3)
        expect(image[:data][:type]).to eq("image")
        expect(image[:data][:attributes].count).to eq(4)
        expect(image[:data][:attributes].keys).to eq([:description, :image_url, :source, :author])

        expect(image[:data][:attributes][:description]).to be_a(String)
        expect(image[:data][:attributes][:image_url]).to be_a(String)
        expect(image[:data][:attributes][:source]).to be_a(String)
        expect(image[:data][:attributes][:author]).to be_a(String)
      end
    end

    describe 'sad path' do
      it 'renders a 400 error if location is nil', :vcr do
        get "/api/v1/backgrounds", params: {location: ""}
        expect(response.status).to be(400)
        image = JSON.parse(response.body, symbolize_names: true)
        expect(image[:error]).to eq("Location not found")
      end

      it 'renders a 400 error if location is not present', :vcr do
        get "/api/v1/backgrounds"
        expect(response.status).to be(400)
        image = JSON.parse(response.body, symbolize_names: true)
        expect(image[:error]).to eq("Location not found")
      end
    end
  end
end
