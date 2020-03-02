class HourlyForecast
  def initialize(hourly_weather_data)
    @hourly_data = hourly_weather_data
  end

  def next_eight_hours
    hourly_data.map do |hour|
      {
        hour_of_day: time(hour),
        weather_icon: icon(hour),
        temp_F: temp(hour)
      }
    end[0..7]
  end

  private

  attr_reader :hourly_data

  def time(hour)
    Time.at(hour[:time]).strftime('%-I %p')
  end

  def icon(hour)
    hour[:icon]
  end

  def temp(hour)
    hour[:temperature].round
  end
end
