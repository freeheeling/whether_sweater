class Api::V1::BackgroundsController < ApplicationController
  def index
    location = params[:location]
    image = BackgroundFacade.new(location)
    render json: BackgroundSerializer.new(image)
  end
end
