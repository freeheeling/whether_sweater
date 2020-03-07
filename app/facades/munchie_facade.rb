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
    @end_location = get_destination
    @travel_time = get_travel_duration
    @forecast = get_weather_upon_arrival
    @restaurant = get_restaurant_info
  end

  def get_restaurant_info
    Restaurant.new(restaurant_data)
  end

  def restaurant_data
    YelpService.new(lat, long, cuisine, arrival_time).business_from_term[:businesses]
  end

  def route_data
    @route_data ||= GoogleService.new(origin, destination).directions_data
  end

  private

  attr_reader :origin,
              :destination,
              :cuisine

  def arrival_time
    travel_time = route_data[:duration][:value]
    Time.now.to_i + travel_time
  end

  def forecast_data
    DarkskyService.new(lat, long, arrival_time).future_darksky_data
  end

  def get_weather_upon_arrival
    forecast_data[:currently][:summary]
  end

  def get_destination
    route_data[:end_address].gsub( /.{5}$/, '' )
  end

  def get_travel_duration
    route_data[:duration][:text]
  end

  def lat # destination
    route_data[:end_location][:lat]
  end

  def long # destination
    long = route_data[:end_location][:lng]
  end
end
