class RoadTripFacade
  attr_reader :id,
              :origin,
              :destination,
              :travel_time,
              :arrival_forecast

  def initialize(start_location, end_location)
    @id = id
    @start_location = start_location
    @end_location = end_location
    @origin = get_origin
    @destination = get_destination
    @travel_time = get_travel_time
    @arrival_forecast = get_arrival_forecast
  end

  private

  attr_reader :start_location,
              :end_location

  def route_data
    @route_data ||= GoogleService.new(start_location, end_location).directions_data
  end

  def lat
    route_data[:end_location][:lat]
  end

  def long
    route_data[:end_location][:lng]
  end

  def road_trip_data
    RoadTripForecast.new(lat, long, future_time)
  end

  def future_time
    Time.now.to_i + route_data[:duration][:value]
  end

  def get_origin
    route_data[:start_address].gsub( /.{5}$/, '' )
  end

  def get_destination
    route_data[:end_address].gsub( /.{5}$/, '' )
  end

  def get_travel_time
    route_data[:duration][:text]
  end

  def get_arrival_forecast
    summary = road_trip_data.future_summary
    temp = road_trip_data.future_temp
    "#{temp}°, #{summary}"
  end
end
