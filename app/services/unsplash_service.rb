class UnsplashService
  class << self
    def get_city_image(location)
      resp = conn.get("/photos/random?query=#{location} downtown") do |faraday|
        faraday.params['count'] = 1
      end
      parse_json(resp)
    end

    private

    def conn
      Faraday.new(
        url: "https://api.unsplash.com",
        params: { client_id: ENV['UNSPLASH_KEY']}
      )
    end

    def parse_json(resp)
      JSON.parse(resp.body, symbolize_names: true)
    end
  end
end
