require 'rails_helper'

RSpec.describe Book do
  describe 'it encapsulates and returns books' do
    it 'returns the book object with attributes' do
      book_info = {
        "id": "null",
        "type": "books",
        "attributes": {
          "destination": "denver,co",
          "forecast": {
            "summary": "Cloudy with a chance of meatballs",
            "temperature": "83 F"
          },
          "total_books_found": 172,
          "books": [
            {
              "isbn": [
                "0762507845",
                "9780762507849"
              ],
              "title": "Denver, Co",
              "publisher": [
                "Universal Map Enterprises"
              ]
            }
          ]
        }
      }

      book = Book.new(book_info)
      expect(book).to be_a Book
      expect(book.destination).to eq("denver,co")
      expect(book.forecast.count).to eq(2)
      expect(book.total_books_found).to eq(172)
      expect(book.books.count).to eq(5)
    end
  end
end
