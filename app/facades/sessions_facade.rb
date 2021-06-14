class SessionsFacade
  class << self
    def post_user_session(user)
      Session.new(user)
    end
  end
end
