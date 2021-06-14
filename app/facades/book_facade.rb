class BookFacade
  class << self
    def get_books(location, quantity)
      require "pry"; binding.pry
      lat_lon = MapquestService.get_lat_long(location)
      lat = lat_lon[:results].first[:locations].first[:latLng][:lat]
      lon = lat_lon[:results].first[:locations].first[:latLng][:lng]
      weather = OpenweatherService.get_forecast(lat, lon)
      forecast = {
        summary: weather[:current][:weather].first[:description],
        temperature: (weather[:current][:temp] - 273) * 1.8 + 32
      }
      require "pry"; binding.pry
      # books = OpenlibraryService.find_books(book)
      # Book.new(books)
    end
  end
end
