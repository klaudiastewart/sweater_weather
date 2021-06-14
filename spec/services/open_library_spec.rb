require 'rails_helper'

RSpec.describe 'Open Library Service' do
  describe 'calls to the API' do
    it 'can find_books for a given location', :vcr do
      call = OpenlibraryService.find_books('denver,co', 5)
      expect(call.class).to eq(Array)
    end
  end
end
