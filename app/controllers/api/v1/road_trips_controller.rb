class Api::V1::RoadTripsController < ApplicationController
  def create
    user = User.find_by(api_key: request_params[:api_key])
    if user
      road_trip_data = RoadTripFacade.new(origin, destination)
      render json: RoadTripSerializer.new(road_trip_data)
    else
      unsuccessful = ErrorMessage.new(user)
      render json: InvalidKeySerializer.new(unsuccessful), status: 401
    end
  end

  private

  attr_reader :origin,
              :destination

  def request_params
    params.permit(:origin, :destination, :api_key)
  end

  def origin
    request_params[:origin]
  end

  def destination
    request_params[:destination]
  end
end
