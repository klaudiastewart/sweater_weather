class WeatherFacade
  class << self
    def get_forecast(location)
      lat_lon = MapquestService.get_lat_long(location)
      return lat_lon if lat_lon.class == String
      lat = lat_lon[:results].first[:locations].first[:latLng][:lat]
      lon = lat_lon[:results].first[:locations].first[:latLng][:lng]
      forecast = OpenweatherService.get_forecast(lat, lon)
      daily = daily_weather(forecast)[0..4]
      hourly = hourly_weather(forecast)[0..7]
      Forecast.new(current_weather(forecast), daily, hourly)
    end

    def current_weather(forecast)
      current_weather = {
        datetime: Time.at(forecast[:current][:dt]).to_s,
        sunrise: Time.at(forecast[:current][:sunrise]).to_s,
        sunset: Time.at(forecast[:current][:sunset]).to_s,
        temperature: (forecast[:current][:temp] - 273) * 1.8 + 32,
        feels_like: (forecast[:current][:feels_like] - 273) * 1.8 + 32,
        humidity: forecast[:current][:humidity],
        uvi: forecast[:current][:uvi],
        visibility: forecast[:current][:visibility],
        conditions: forecast[:current][:weather].first[:description],
        icon: forecast[:current][:weather].first[:icon]
      }
    end

    def daily_weather(forecast)
      daily_weather = forecast[:daily].map do |day|
        {
          date: Time.at(day[:dt]).to_date,
          sunrise: Time.at(day[:sunrise]).to_s(:time),
          sunset: Time.at(day[:sunset]).to_s(:time),
          max_temp: (day[:temp][:max] - 273) * 1.8 + 32,
          min_temp: (day[:temp][:min] - 273) * 1.8 + 32,
          conditions: day[:weather].first[:description],
          icon: day[:weather].first[:icon]
        }
      end
    end

    def hourly_weather(forecast)
      hourly_weather = forecast[:hourly].map do |hour|
        {
          time: Time.at(hour[:dt]).to_s(:time),
          temp: (hour[:temp] - 273) * 1.8 + 32,
          conditions: hour[:weather].first[:description],
          icon: hour[:weather].first[:icon]
        }
      end
    end
  end
end
