class Api::V1::Users::SessionsController < ApplicationController
  def create
    @user = User.find_by_email(params[:email])
    if !@user.present? || !@user.authenticate(params[:password])
      return bad_params_401("No authorization")
    else
      user_session = SessionsFacade.post_user_session(@user)
      render json: UserSerializer.new(user_session)
    end
  end
end
