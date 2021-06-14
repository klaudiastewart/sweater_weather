require 'rails_helper'

RSpec.describe 'Books Controller, api::v1::Bookscontroller', type: :request do
  let(:valid_headers) {
   {"CONTENT_TYPE" => "application/json"}
   {"Etag" => "f22061f294b256cf0e04fa4d150cee30"}
   {"Cache-Control" => "max-age=0, private, must-revalidate"}
   {"X-Request-id" => "aab43c90-7f82-4ec7-9101-6a22b6e341e4"}
   {"X-Runtime" => "0.095101"}
   {"Transfer-Encoding" => "chunked"}
  }

  describe 'GET /book-search' do
    describe 'happy path' do
      it 'can get destination, forecast, total books found, and books for a get /book-search request', :vcr do
        get "/api/v1/book-search", params: {location: "denver,co", quantity: 5}
        book = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(book).to be_a(Hash)
        expect(book[:data].count).to eq(3)
        expect(book[:data][:type]).to eq("book")
        expect(book[:data][:attributes].count).to eq(4)
        expect(book[:data][:attributes].keys).to eq([:destination, :forecast, :books_found, :books])

        expect(book[:data][:attributes][:destination]).to be_a(String)
        expect(book[:data][:attributes][:forecast]).to be_a(Hash)
        expect(book[:data][:attributes][:books_found]).to be_a(Integer)
        expect(book[:data][:attributes][:books]).to be_a(Array)

        expect(book[:data][:attributes][:forecast].keys).to eq([:summary, :temperature])
        expect(book[:data][:attributes][:forecast][:summary]).to be_a(String)
        expect(book[:data][:attributes][:forecast][:temperature]).to be_a(String)

        expect(book[:data][:attributes][:books].count).to eq(5)
        expect(book[:data][:attributes][:books].first.keys).to eq([:isbn, :title, :publisher])
        expect(book[:data][:attributes][:books].first[:isbn].count).to eq(2)
        expect(book[:data][:attributes][:books].first[:title]).to be_a(String)
        expect(book[:data][:attributes][:books].first[:publisher].count).to eq(1)
        expect(book[:data][:attributes][:books].first[:publisher].first).to be_a(String)
      end
    end

    describe 'sad path' do
      it 'renders a 400 error if q and query is empty and quantity is 0', :vcr do
        get "/api/v1/book-search", params: {location: "", quantity: 0}
        expect(response.status).to be(400)
        book = JSON.parse(response.body, symbolize_names: true)
        expect(book[:error]).to eq("Book not found")
      end

      it 'renders a 400 error if quantity and query is not present', :vcr do
        get "/api/v1/book-search"
        expect(response.status).to be(400)
        book = JSON.parse(response.body, symbolize_names: true)
        expect(book[:error]).to eq("Book not found")
      end
    end
  end
end
