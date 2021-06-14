class OpenlibraryService
  class << self
    def find_books(location, quantity)
      resp = conn.get("/search.json") do |faraday|
        faraday.params['q'] = location
        faraday.params['limit'] = quantity
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
