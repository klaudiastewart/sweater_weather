require 'rails_helper'

RSpec.describe 'Roadtrip Facade' do
  describe 'Facade can get a forecast' do
    it 'gets roadtrip information for a origin to destination place', :vcr do
      response = RoadtripFacade.get_road_trip('denver,co', 'ouray,co')
      expect(response.class).to eq(Roadtrip)
    end

    it 'gets directions', :vcr do
      response = RoadtripFacade.directions('denver,co', 'ouray,co')
      expect(response.class).to eq(Hash)
      expect(response.keys).to eq([:route, :info])
      expect(response.keys.size).to eq(2)
    end

    it 'gets a forecast for the destination for the trip time arrival that is less than 24 hours', :vcr do
      response = RoadtripFacade.get_forecast(38.022751, -104.98484, '05:25:22')
      expect(response.class).to eq(Hash)
      expect(response.keys).to eq([:temperature, :description])
      expect(response.keys.size).to eq(2)
    end

    it 'gets a forecast for the destination for the trip time arrival that is over than 24 hours', :vcr do
      response = RoadtripFacade.get_forecast(38.022751, -104.98484, '35:25:22')
      expect(response.class).to eq(Hash)
      expect(response.keys).to eq([:temperature, :description])
      expect(response.keys.size).to eq(2)
    end
  end
end
