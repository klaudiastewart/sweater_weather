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
      it 'can GET(forecast) current weather, daily weather, and hourly weather', :vcr do
        get "/api/v1/forecast", params: {location: "denver,co"}
        forecast = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(forecast).to be_a(Hash)
        expect(forecast[:data].count).to eq(3)
        expect(forecast[:data][:type]).to eq("forecast")
        expect(forecast[:data][:attributes].keys).to eq([:current_weather, :daily_weather, :hourly_weather, :id])

        expect(forecast[:data][:attributes][:current_weather][:datetime]).to be_a(String)
        expect(forecast[:data][:attributes][:current_weather][:sunrise]).to be_a(String)
        expect(forecast[:data][:attributes][:current_weather][:sunset]).to be_a(String)
        expect(forecast[:data][:attributes][:current_weather][:temperature]).to be_a(Float)
        expect(forecast[:data][:attributes][:current_weather][:feels_like]).to be_a(Float)
        expect(forecast[:data][:attributes][:current_weather][:humidity]).to be_a(Integer)
        expect(forecast[:data][:attributes][:current_weather][:uvi]).to be_a(Float)
        expect(forecast[:data][:attributes][:current_weather][:uvi]).to be_a(Float)
        expect(forecast[:data][:attributes][:current_weather][:visibility]).to be_a(Integer)
        expect(forecast[:data][:attributes][:current_weather][:conditions]).to be_a(String)
        expect(forecast[:data][:attributes][:current_weather][:icon]).to be_a(String)

        expect(forecast[:data][:attributes][:daily_weather].first[:date]).to be_a(String)
        expect(forecast[:data][:attributes][:daily_weather].first[:sunrise]).to be_a(String)
        expect(forecast[:data][:attributes][:daily_weather].first[:sunset]).to be_a(String)
        expect(forecast[:data][:attributes][:daily_weather].first[:max_temp]).to be_a(Float)
        expect(forecast[:data][:attributes][:daily_weather].first[:min_temp]).to be_a(Float)
        expect(forecast[:data][:attributes][:daily_weather].first[:conditions]).to be_a(String)
        expect(forecast[:data][:attributes][:daily_weather].first[:icon]).to be_a(String)

        expect(forecast[:data][:attributes][:hourly_weather].first[:time]).to be_a(String)
        expect(forecast[:data][:attributes][:hourly_weather].first[:temp]).to be_a(Float)
        expect(forecast[:data][:attributes][:hourly_weather].first[:conditions]).to be_a(String)
        expect(forecast[:data][:attributes][:hourly_weather].first[:icon]).to be_a(String)
      end
    end
  end
end
