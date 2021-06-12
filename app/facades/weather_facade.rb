class WeatherFacade
  class << self
    def get_forecast(location)
      lat_long = MapquestService.get_lat_long(location)
      require "pry"; binding.pry
    end
  end
end
