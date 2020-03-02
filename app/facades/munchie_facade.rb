class MunchieFacade
  attr_reader :id,
              :end_location,
              :travel_time

  def initialize(origin, destination, cuisine)
    @id = nil
    @origin = origin
    @destination = destination
    @cuisine = cuisine
    @end_location = route_data.first[:end_address]
    @travel_time = route_data.first[:duration][:text]
  end

  def route_data
    @route_data ||= GoogleService.new(origin, destination).directions_data
  end

  def forecast_data
    lat = route_data.first[:end_location][:lat] # destination
    long = route_data.first[:end_location][:lng] # destination
    @forecast_data ||= DarkskyService.new(lat, long).darksky_data
  end

  def forecast
    Forecast.new(forecast_data)
  end

  def restaurant

  end

  private

  attr_reader :origin,
              :destination,
              :cuisine
end
