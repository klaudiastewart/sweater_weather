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
      daily_weather = forecast[:daily].map do |day|
        {
          date: Time.at(day[:dt]).to_date,
               sunrise: Time.at(day[:sunrise]).to_s(:time),
               sunset: Time.at(day[:sunset]).to_s(:time),
               max_temp: day[:temp][:max],
               min_temp: day[:temp][:min],
               conditions: day[:weather].first[:description],
               icon: day[:weather].first[:icon]
        }
      end
      hourly_weather = forecast[:hourly].map do |hour|
        {
          time: Time.at(hour[:dt]).to_s(:time),
          temp: hour[:temp],
          conditions: hour[:weather].first[:description],
          icon: hour[:weather].first[:icon]
        }
      end

      daily = daily_weather[0..4]
      hourly = hourly_weather[0..7]

      Forecast.new(current_weather, daily, hourly)
    end
  end
end
