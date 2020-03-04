class Forecast
  def initialize(forecast_data)
    @current_weather = current_weather(forecast_data)
    @daily_forecast = daily_forecast(forecast_data)
    @hourly_forecast = hourly_forecast(forecast_data)
  end

  def current_weather(forecast_data)
    CurrentWeather.new(forecast_data)
  end

  def hourly_forecast(forecast_data)
    hourly_data(forecast_data)[0..7].map do |hour|
      HourlyForecast.new(hour)
    end
  end

  def daily_forecast(forecast_data)
    daily_data(forecast_data)[1..5].map do |day|
      DailyForecast.new(day)
    end
  end

  private

  attr_reader :forecast_data

  def daily_data(forecast_data)
    forecast_data[:daily][:data]
  end

  def hourly_data(forecast_data)
    forecast_data[:hourly][:data]
  end
end
