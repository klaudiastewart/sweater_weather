require 'rails_helper'

RSpec.describe 'Mapquest Service' do
  describe 'calls to the API' do
    it 'can get_lat_long for a given location', :vcr do
      call = MapquestService.get_lat_long('denver,co')
      expect(call.class).to eq(Hash)
    end

    it 'can get_trip_directions', :vcr do
      call = MapquestService.get_trip_directions('denver,co', 'ouray,co')
      expect(call.class).to eq(Hash)
    end
  end
end
