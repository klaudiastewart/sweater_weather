require 'rails_helper'

RSpec.describe 'Weather Facade' do
  describe 'Facade can get a forecast' do
    before(:each) do
      @lat_lng = MapquestService.get_lat_long('denver,co')
      @forecast = OpenweatherService.get_forecast(
        @lat_lng[:results][0][:locations][0][:latLng][:lat],
        @lat_lng[:results][0][:locations][0][:latLng][:lng]
      )
    end

    it 'returns current weather', :vcr do
      response = WeatherFacade.get_forecast('denver,co')
      expect(response.class).to eq(Forecast)
    end
  end
end
