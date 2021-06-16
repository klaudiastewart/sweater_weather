require 'rails_helper'

RSpec.describe 'Sessions Facade' do
  describe 'Facade can get user info' do
    it 'gets user info', :vcr do
      @user = User.create(email: 'klaudia@test.com', password: 'password', password_confirmation: 'password')
      response = SessionsFacade.post_user_session(@user)

      expect(response.class).to eq(Session)
      expect(response.email).to eq(@user.email)
    end
  end
end
