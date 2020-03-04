class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: user_params[:email])
    if user && user.authenticate(user_params[:password])
      render json: SuccessfulLoginSerializer.new(user), status: 200
    else
      unsuccessful = UserErrorMessage.new(user)
      render json: FailedLoginSerializer.new(unsuccessful), status: 401
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
