class Api::V1::UsersController < ApplicationController
  def create
    user = User.create(user_params)
    if user.save
      render json: SuccessfulRegistrationSerializer.new(user), status: 201
    else
      unsuccessful = ErrorMessage.new(user)
      render json: FailedRegistrationSerializer.new(unsuccessful), status: 400
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
