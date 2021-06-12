class WeatherFacade
  class << self
    def get_forecast(location)
      lat_lon = MapquestService.get_lat_long(location)
      lat = lat_lon[:results].first[:locations].first[:latLng][:lat]
      lon = lat_lon[:results].first[:locations].first[:latLng][:lng]
      forecast = OpenweatherService.get_forecast(lat, lon)

      current_weather = {
        datetime: Time.at(forecast[:current][:dt]).to_s,
        sunrise: Time.at(forecast[:current][:sunrise]).to_s,
        sunset: Time.at(forecast[:current][:sunset]).to_s,
        temperature: forecast[:current][:temp],
        feels_like: forecast[:current][:feels_like],
        humidity: forecast[:current][:humidity],
        uvi: forecast[:current][:uvi],
        visibility: forecast[:current][:visibility],
        conditions: forecast[:current][:weather].first[:description],
        icon: forecast[:current][:weather].first[:icon]
      }

      daily_weather = {

      }

      hourly_weather = {

      }
      
      Forecast.new(forecast)
    end
  end
end
