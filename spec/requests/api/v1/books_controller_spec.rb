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
        get "/api/v1/books-search", params: {q: "denver,co", quantity: 5}
        response = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(image).to be_a(Hash)
        expect(image[:data].count).to eq(3)
        expect(image[:data][:type]).to eq("books")
        expect(image[:data][:attributes].count).to eq(4)
        expect(image[:data][:attributes].keys).to eq([:destination, :forecast, :total_books_found, :books])

        expect(image[:data][:attributes][:destination]).to be_a(String)
        expect(image[:data][:attributes][:forecast]).to be_a(Hash)
        expect(image[:data][:attributes][:total_books_found]).to be_a(Integer)
        expect(image[:data][:attributes][:books]).to be_a(Array)

        expect(image[:data][:attributes][:forecast].keys).to eq([:summary, :temperature])
        expect(image[:data][:attributes][:forecast][:summary]).to be_a(String)
        expect(image[:data][:attributes][:forecast][:temperature]).to be_a(String)

        expect(image[:data][:attributes][:books].count).to eq(5)
        expect(image[:data][:attributes][:books].first.keys).to eq([:isbn, :title, :publisher])
        expect(image[:data][:attributes][:books].first[:isbn].count).to eq(2)
        expect(image[:data][:attributes][:books].first[:title]).to be_a(String)
        expect(image[:data][:attributes][:books].first[:publisher].count).to eq(1)
        expect(image[:data][:attributes][:books].first[:publisher].first).to be_a(String)
      end
    end

    describe 'sad path' do
      it 'renders a 400 error if q and query is empty and quantity is 0', :vcr do
        get "/api/v1/books-search", params: {q: "", quantity: 0}
        expect(response.status).to be(400)
        response = JSON.parse(response.body, symbolize_names: true)
        expect(response[:error]).to eq("Query not found")
      end

      it 'renders a 400 error if quantity and query is not present', :vcr do
        get "/api/v1/books-search"
        expect(response.status).to be(400)
        response = JSON.parse(response.body, symbolize_names: true)
        expect(response[:error]).to eq("Query not found")
      end
    end
  end
end
