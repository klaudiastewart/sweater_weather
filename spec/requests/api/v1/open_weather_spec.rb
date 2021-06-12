require 'rails_helper'

RSpec.describe 'Open Weather API, api::v1::weathercontroller', type: :request do
  let(:valid_headers) {
   {"CONTENT_TYPE" => "application/json"}
   {"Etag" => "f22061f294b256cf0e04fa4d150cee30"}
   {"Cache-Control" => "max-age=0, private, must-revalidate"}
   {"X-Request-id" => "aab43c90-7f82-4ec7-9101-6a22b6e341e4"}
   {"X-Runtime" => "0.095101"}
   {"Transfer-Encoding" => "chunked"}
 }

  describe 'Getting information from this API' do
    describe 'Happy path' do
      it 'can GET(forecast) current weather, daily weather, and hourly weather' do
        get "/api/v1/forecast", params: {location: "denver,co"}
        expect(response).to be_successful
        forecast = JSON.parse(response.body, symbolize_names: true)
        expect(forecast).to be_a(Hash)
        expect(forecast)
        expect(forecast[:data.count]).to eq(3)
        expect(forecast[:data][:type]).to eq("forecast")
        expect(forecast[:data][:attributes].keys).to eq([:current_weather, :daily_weather, :hourly_weather, :id])
        expect(forecast[:data][:attributes][:current_weather][:datetime]).to be_a(String)
        require "pry"; binding.pry
      end
    end
  end
end
