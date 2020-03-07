class HourlyForecast
  attr_reader :hour_of_day,
              :unix_timestamp,
              :weather_icon,
              :temp_F

  def initialize(hour)
    @hour_of_day = time(hour)
    @unix_timestamp = get_unix_timestamp(hour)
    @weather_icon = get_weather_icon(hour)
    @temp_F = get_temp_F(hour)
  end

  private

  def get_unix_timestamp(hour)
    hour[:time]
  end

  def get_weather_icon(hour)
    hour[:icon]
  end

  def get_temp_F(hour)
    hour[:temperature].round
  end

  def time(hour)
    Time.at(hour[:time]).strftime('%-I %p')
  end
end
