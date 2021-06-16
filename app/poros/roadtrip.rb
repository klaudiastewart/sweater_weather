class Roadtrip
  attr_reader :id,
              :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(origin, destination, time, forecast)
    @id = nil
    @start_city = origin
    @end_city = destination
    @travel_time = time
    @weather_at_eta = forecast
  end
end
