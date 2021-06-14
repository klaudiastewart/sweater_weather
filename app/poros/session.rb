class Session
  attr_reader :id,
              :email,
              :api_key

  def initialize(user_data)
    @id = user_data.id
    @email = user_data.email
    @api_key = user_data.api_key
  end
end
