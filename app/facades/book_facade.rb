class BookFacade
  class << self
    def get_books(book)
      books = OpenlibraryService.find_books(book)
      Book.new(books)
    end
  end
end
