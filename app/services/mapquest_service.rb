class MapquestService
  class << self
    def get_lat_long(location)
      resp = conn.get("/geocoding/v1/address") do |faraday|
        faraday.params['location'] = location
      end
      parse_json(resp)
      # resp.body.present? == false
      # return "No location found" if !resp.body.present? #resp.env.request_body.empty?
    end

    private

    def conn
      Faraday.new(
        url: "http://www.mapquestapi.com",
        params: { key: ENV['MAPQUEST_KEY']}
      )
    end

    def parse_json(resp)
      JSON.parse(resp.body, symbolize_names: true)
    end
  end
end
