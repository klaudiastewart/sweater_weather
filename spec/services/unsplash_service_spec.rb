require 'rails_helper'

RSpec.describe 'Unspalsh Service' do
  describe 'calls to the API' do
    it 'can get_city_image for a given location', :vcr do
      call = UnsplashService.get_city_image('denver,co')
      expect(call.class).to eq(Array)
    end
  end
end
