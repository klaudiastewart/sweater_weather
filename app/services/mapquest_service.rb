class MapquestService
  class << self
    def get_lat_long(location)
      resp = conn.get("/geocoding/v1/address") do |faraday|
        faraday.params['location'] = location
      end
      return "No location found" if !resp.body.present? #resp.env.request_body.empty?
      parse_json(resp)
    end

    def get_trip_directions(origin, destination)
      resp = conn.get("/directions/v2/route") do |faraday|
        faraday.params['from'] = origin
        faraday.params['to'] = destination
      end
      return "Impossible route" if parse_json(resp)[:info][:messages] == ["We are unable to route with the given locations."]
      parse_json(resp)
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
