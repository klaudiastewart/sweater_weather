require 'rails_helper'

RSpec.describe Session do
  describe 'it encapsulates and returns a user session' do
    it 'returns the session object with attributes' do
      @user = User.create(email: 'klaudia@test.com', password: 'password', password_confirmation: 'password')
      session = Session.new(@user)
      expect(session).to be_a(Session)
      expect(session.email).to eq("klaudia@test.com")
    end
  end
end
