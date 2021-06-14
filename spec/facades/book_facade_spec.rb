require 'rails_helper'

RSpec.describe 'Book Facade' do
  describe 'Facade can get books' do
    before(:each) do
      @lat_lng = MapquestService.get_lat_long('denver,co')
      @forecast = OpenweatherService.get_forecast(
        @lat_lng[:results][0][:locations][0][:latLng][:lat],
        @lat_lng[:results][0][:locations][0][:latLng][:lng]
      )
    end

    it 'gets current weather, daily weather, and hourly weather to make a forecast object', :vcr do
      response = WeatherFacade.get_forecast('denver,co')
      expect(response.class).to eq(Forecast)
    end

    it 'gets books based on location', :vcr do
      response = BookFacade.get_books('denver, co', 5)
      expect(response.class).to eq(Hash)
    end
  end
end
