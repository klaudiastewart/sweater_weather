class RoadtripFacade
  class << self
    def get_road_trip(origin, destination)
      directions = directions(origin, destination)
      return directions if directions.class == String
      time = directions[:route][:formattedTime]
      lon = directions[:route][:boundingBox][:lr][:lng]
      lat = directions[:route][:boundingBox][:lr][:lat]
      forecast = get_forecast(lat, lon, time)
      Roadtrip.new(origin, destination, time, forecast)
    end

    def directions(origin, destination)
      directions = MapquestService.get_trip_directions(origin, destination)
    end

    def get_forecast(lat, lon, time)
      forecast = OpenweatherService.get_forecast(lat, lon)
      trip_hours = if time.to_i <= 24
                    time.to_i
                  else
                    Time.now.strftime("%T").to_i + time.to_i
                  end
      description = []
      temperature = []

      if trip_hours >= 24
        forecast[:daily].find_all do |day|
          if Time.now.to_i + (trip_hours * 3600).to_i >= day[:dt]
            temperature << "#{((day[:temp][:day]- 273) * 1.8 + 32).round(2)}"
            description << day[:weather][0][:description]
          end
        end
        daily_weather = {
          temperature: temperature.last,
          description: description.last
        }
      else
        forecast[:hourly].find_all do |hour|
          if Time.now.to_i + (trip_hours * 3600).to_i >= hour[:dt]
            temperature << "#{((hour[:temp]- 273) * 1.8 + 32).round(2)}"
            description << hour[:weather][0][:description]
          end
        end
        hourly_weather = {
          temperature: temperature.last.to_i.round(2),
          description: description.last
        }
      end
    end
  end
end
