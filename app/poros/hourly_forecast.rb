class HourlyForecast
  attr_reader :hour_of_day,
              :weather_icon,
              :temp_F

  def initialize(hour)
    @hour_of_day = time(hour)
    @weather_icon = hour[:icon]
    @temp_F = hour[:temperature].round
  end

  private

  def time(hour)
    Time.at(hour[:time]).strftime('%-I %p')
  end
end
