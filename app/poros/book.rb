class Book
  attr_reader :destination,
              :forecast,
              :books_found,
              :books,
              :id 

  def initialize(destination, forecast, books_found, books)
    @id = nil
    @destination = destination
    @forecast = forecast
    @books_found = books_found
    @books = books
  end
end
