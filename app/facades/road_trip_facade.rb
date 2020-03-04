class RoadTripFacade
  attr_reader :id,
              :origin,
              :destination,
              :travel_time

  def initialize(start_location, end_location)
    @id = id
    @start_location = start_location
    @end_location = end_location
    @origin = route_data[:start_address].gsub( /.{5}$/, '' )
    @destination = route_data[:end_address].gsub( /.{5}$/, '' )
    @travel_time = route_data[:duration][:text]
  end

  def route_data
    @route_data ||= GoogleService.new(start_location, end_location).directions_data
  end

  def arrival_forecast
    summary = RoadTripForecast.new(lat, long, future_time).future_summary
    temp = RoadTripForecast.new(lat, long, future_time).future_temp
    "#{temp}°, #{summary}"
  end

  private

  attr_reader :start_location,
              :end_location,
              :future_temp,
              :future_forecast

  def lat
    route_data[:end_location][:lat]
  end

  def long
    route_data[:end_location][:lng]
  end

  def future_time
    Time.now.to_i + route_data[:duration][:value]
  end
end
