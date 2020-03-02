class CurrentWeather
  def initialize(current_weather_data)
    @forecast_data = current_weather_data
  end

  def current_conditions
    {
      time_and_date: current_datetime,
      weather_conditions: current_summary,
      weather_icon: current_icon,
      temp_F: current_temp,
      feels_like_F: feels_like,
      humidity_percent: humidity,
      visibility_miles: visibility,
      uv_index_number: uv_index,
      today_summary: today_summary,
      tonight_summary: next_night_hour_summary
    }
  end

  private

  attr_reader :forecast_data

  def current_datetime
    Time.at(forecast_data[:currently][:time]).strftime('%-I:%M %p, %-m/%-d')
  end

  def current_summary
    forecast_data[:currently][:summary]
  end

  def current_icon
    forecast_data[:currently][:icon]
  end

  def current_temp
    forecast_data[:currently][:temperature].round
  end

  def feels_like
    forecast_data[:currently][:apparentTemperature].round
  end

  def humidity
    (forecast_data[:currently][:humidity] * 100).to_i
  end

  def visibility
    forecast_data[:currently][:visibility]
  end

  def uv_index
    forecast_data[:currently][:uvIndex]
  end

  def today_summary
    forecast_data[:daily][:summary]
  end

  def next_night_hour_summary
    forecast_data[:hourly][:data].find do |hour|
      hour[:icon].include?('night')
    end[:summary]
  end
end
