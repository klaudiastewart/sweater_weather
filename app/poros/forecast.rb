class Forecast
  attr_reader :id,
              :current_weather,
              :daily_weather,
              :hourly_weather

  def initialize(current_weather, daily, hourly)
    @id = nil
    @current_weather = current_weather
    @daily_weather = daily
    @hourly_weather = hourly
  end
end
