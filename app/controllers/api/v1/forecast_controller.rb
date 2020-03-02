class Api::V1::ForecastController < ApplicationController
  def index
    location = params[:location]
    forecast_data = ForecastFacade.new(location)
    render json: ForecastSerializer.new(forecast_data)
  end
end
