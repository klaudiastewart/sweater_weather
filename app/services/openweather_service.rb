class OpenweatherService
  class << self
    def get_forecast(lat, lon)
      resp = conn.get("/data/2.5/onecall") do |faraday|
        faraday.params['lat'] = lat
        faraday.params['lon'] = lon
      end
      parse_json(resp)
    end

    private

    def conn
      Faraday.new(
        url: "https://api.openweathermap.org",
        params: { appid: ENV['OPENWEATHER_KEY']}
      )
    end

    def parse_json(resp)
      JSON.parse(resp.body, symbolize_names: true)
    end
  end
end
