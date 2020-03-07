class Api::V1::MunchiesController < ApplicationController
  def index
    origin = params[:start]
    destination = params[:end]
    cuisine = params[:food]

    munchie = MunchieFacade.new(origin, destination, cuisine)
    render json: MunchieSerializer.new(munchie)
  end
end
