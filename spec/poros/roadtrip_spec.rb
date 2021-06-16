require 'rails_helper'

RSpec.describe Roadtrip do
  describe 'it encapsulates and returns a roadtrip' do
    it 'returns the roadtrip object with attributes' do
      origin = 'denver,co'
      destination = 'ouray,co'
      time = '05:37:59'
      forecast = {
                "temperature": 70,
                "description": "overcast clouds"
            }

    @road_trip = Roadtrip.new(origin, destination, time, forecast)
    expect(@road_trip).to be_a(Roadtrip)
    expect(@road_trip.start_city).to eq("denver,co")
    expect(@road_trip.end_city).to eq("ouray,co")
    expect(@road_trip.travel_time).to eq("05:37:59")
    expect(@road_trip.weather_at_eta).to eq({:temperature=>70, :description=>"overcast clouds"})
    end
  end
end
