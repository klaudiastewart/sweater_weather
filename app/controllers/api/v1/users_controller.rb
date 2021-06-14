class Api::V1::UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.password != @user.password_confirmation || !@user.password.present?
      render json: @user.errors, status: :unprocessable_entity
    else
      @user.save
      @user.update(api_key: SecureRandom.hex)
      render json: UserSerializer.new(@user), status: :created
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
