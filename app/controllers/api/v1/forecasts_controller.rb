class Api::V1::ForecastsController < ApplicationController
  def index
    location = params[:location]
    forecast = ForecastFacade.new(location)
    render json: ForecastSerializer.new(forecast)
  end
end
