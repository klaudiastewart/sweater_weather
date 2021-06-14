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

    it 'gets current weather, daily weather, and hourly weather to make a forecast object', :vcr do
      response = WeatherFacade.get_forecast('denver,co')
      expect(response.class).to eq(Forecast)
    end

    it 'gets current_weather', :vcr do
      response = WeatherFacade.current_weather(@forecast)
      expect(response.class).to eq(Hash)
      expect(response.keys).to eq([:datetime, :sunrise, :sunset, :temperature, :feels_like, :humidity, :uvi, :visibility, :conditions, :icon])
      expect(response.keys.size).to eq(10)
      expect(response.keys).to_not eq([:dew_point, :clouds, :pressure, :visibility, :wind_speed, :wind_deg, :wind_gust])
    end

    it 'gets hourly_weather', :vcr do
      response = WeatherFacade.hourly_weather(@forecast)
      expect(response.class).to eq(Array)
      expect(response.first.keys).to eq([:time, :temp, :conditions, :icon])
      expect(response.first.keys.size).to eq(4)
      expect(response.first.keys).to_not eq([:wind_speed, :wind_deg, :wind_gust, :feels_like, :humidity, :pressure, :moonrise, :moon_phase, :moonset])
    end

    it 'gets daily_weather', :vcr do
      response = WeatherFacade.daily_weather(@forecast)
      expect(response.class).to eq(Array)
      expect(response.first.keys).to eq([:date, :sunrise, :sunset, :max_temp, :min_temp, :conditions, :icon])
      expect(response.first.keys.size).to eq(7)
      expect(response.first.keys).to_not eq([:wind_speed, :wind_deg, :wind_gust, :feels_like, :humidity, :pressure, :moonrise, :moon_phase, :moonset])
    end
  end
end
