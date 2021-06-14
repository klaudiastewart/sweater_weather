class BookFacade
  class << self
    def get_books(location, quantity)
      lat_lon = MapquestService.get_lat_long(location)
      lat = lat_lon[:results].first[:locations].first[:latLng][:lat]
      lon = lat_lon[:results].first[:locations].first[:latLng][:lng]
      destination  = lat_lon[:results].first[:providedLocation][:location]
      weather = OpenweatherService.get_forecast(lat, lon)
      forecast = {
        summary: weather[:current][:weather].first[:description],
        temperature: (weather[:current][:temp] - 273) * 1.8 + 32
      }
      searched_books = OpenlibraryService.find_books(location, quantity)
      Book.new(destination, forecast, searched_books[:numFound], books_hash(searched_books))
    end

    def books_hash(searched_books)
      books = searched_books[:docs].map do |book|
          {
          isbn: book[:isbn],
          title: book[:title],
          publisher: book[:publisher]
        }
      end
      books.first(5)
    end
  end
end
