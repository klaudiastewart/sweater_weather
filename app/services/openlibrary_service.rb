class UnsplashService
  class << self
    def find_books(book)
      resp = conn.get("") do |faraday|
        faraday.params[''] = ""
      end
      parse_json(resp)
    end

    private

    def conn
      Faraday.new(
        url: "http://openlibrary.org"
      )
    end

    def parse_json(resp)
      JSON.parse(resp.body, symbolize_names: true)
    end
  end
end
