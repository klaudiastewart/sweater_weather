require 'rails_helper'

RSpec.describe 'City Image Facade' do
  describe 'Facade can get a image of a location' do
    it 'gets a image of a city', :vcr do
      response = UnsplashService.get_city_image('san diego,ca')
      expect(response.class).to eq(Array)
      expect(response.first.keys.count).to eq(22)
    end
  end
end
