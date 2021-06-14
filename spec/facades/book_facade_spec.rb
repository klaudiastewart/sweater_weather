require 'rails_helper'

RSpec.describe 'Book Facade' do
  describe 'Facade can get books' do
    before(:each) do
      @lat_lng = MapquestService.get_lat_long('denver,co')
      @forecast = OpenweatherService.get_forecast(
        @lat_lng[:results][0][:locations][0][:latLng][:lat],
        @lat_lng[:results][0][:locations][0][:latLng][:lng]
      )
      @searched_books = OpenlibraryService.find_books('denver,co', 5)
    end

    it 'gets current weather, daily weather, and hourly weather to make a forecast object', :vcr do
      response = WeatherFacade.get_forecast('denver,co')
      expect(response.class).to eq(Forecast)
    end

    it 'gets books based on location', :vcr do
      response = BookFacade.get_books('denver, co', 5)
      expect(response.class).to eq(Book)
    end

    it 'gets books_hash', :vcr do
      response = BookFacade.books_hash(@searched_books)
      expect(response.class).to eq(Array)
      expect(response.count).to eq(5)
      expect(response.first.keys).to eq([:isbn, :title, :publisher])
      expect(response.first.keys.count).to eq(3)
    end
  end
end
