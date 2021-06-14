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

  describe 'GET /books' do
    describe 'happy path' do
    end

    describe 'sad path' do
    end 
  end
end
