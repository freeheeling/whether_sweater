class RoadTripForecast
  def initialize(lat, long, future_time)
    @lat = lat
    @long = long
    @future_time = future_time
  end

  def future_forecast_data
    @future_forecast_data ||= DarkskyService.new(lat, long, future_time).future_darksky_data
  end

  def future_summary
    future_forecast_data[:currently][:summary]
  end

  def future_temp
    future_forecast_data[:currently][:temperature].round
  end

  private

  attr_reader :lat,
              :long,
              :future_time
end
