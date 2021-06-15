class RoadtripFacade
  class << self
    def get_road_trip(origin, destination)
      directions = directions(origin, destination)
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
      # t = Time.parse(time) if time.to_i <= 24
      # trip_seconds = t.hour * 3600 + t.min * 60 + t.sec
      trip_hours = if time.to_i <= 24
                    time.to_i
                  else
                    Time.now.strftime("%T").to_i + time.to_i
                  end
      description = []
      temperature = []

      if trip_hours >= 24 #trip_seconds >= 86400
        forecast[:daily].find_all do |day|
          if Time.now.to_i + (trip_hours * 3600).to_i >= day[:dt]
            temperature << "#{(day[:temp][:day]- 273) * 1.8 + 32} F"
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
            temperature << "#{(hour[:temp]- 273) * 1.8 + 32} F"
            description << hour[:weather][0][:description]
          end
        end
        hourly_weather = {
          temperature: temperature[trip_hours],
          description: description[trip_hours]
        }
      end
    end
  end
end
