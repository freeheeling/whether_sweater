class DailyForecast
  attr_reader :day_of_week,
              :weather_icon,
              :precip_type,
              :precip_probability_percent,
              :high_temp_F,
              :low_temp_F

  def initialize(day)
    @day_of_week = day_full_name(day)
    @weather_icon = day[:icon]
    @precip_type = day[:precipType]
    @precip_probability_percent = (day[:precipProbability] * 100).to_i
    @high_temp_F = (day[:temperatureMax]).round
    @low_temp_F = (day[:temperatureMin]).round
  end

  private

  def day_full_name(day)
    Time.at(day[:time]).strftime('%A')
  end
end
