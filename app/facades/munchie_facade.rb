class MunchieFacade
  attr_reader :id,
              :end_location,
              :travel_time,
              :forecast,
              :restaurant

  def initialize(origin, destination, cuisine)
    @id = nil
    @origin = origin
    @destination = destination
    @cuisine = cuisine
    @end_location = route_data.first[:end_address]
    @travel_time = route_data.first[:duration][:text]
    @forecast = weather_upon_arrival
    @restaurant = restaurant_name_and_address
  end

  def route_data
    @route_data ||= GoogleService.new(origin, destination).directions_data
  end

  def forecast_data
    lat = route_data.first[:end_location][:lat] # destination
    long = route_data.first[:end_location][:lng] # destination
    @forecast_data ||= DarkskyService.new(lat, long).darksky_data
  end

  def weather_upon_arrival
    hours_to_arrive = ((route_data.first[:duration][:value].to_f)/3600).round
    forecast_data[:hourly][:data][hours_to_arrive][:summary]
  end

  def restaurant_data
    lat = route_data.first[:end_location][:lat] # destination
    long = route_data.first[:end_location][:lng] # destination
    YelpService.new(lat, long, cuisine).business_from_term
    require "pry"; binding.pry
  end

  def restaurant_name_and_address
    # address = restaurant_data[:businesses].first[:location]
    {
      name: restaurant_data[:businesses].first[:name]
      # address: 'address[:address1] + ', ' + address[:address2] + ', ' + address[:city] + ', ' + address[:state] + address[:zip]"
    }
  end

  private

  attr_reader :origin,
              :destination,
              :cuisine
end
