class DailyForecast
  attr_reader :day_of_week,
              :unix_timestamp,
              :weather_icon,
              :precip_type,
              :precip_probability_percent,
              :high_temp_F,
              :low_temp_F

  def initialize(day)
    @day_of_week = get_day_of_week(day)
    @unix_timestamp = get_unix_timestamp(day)
    @weather_icon = get_weather_icon(day)
    @precip_type = get_precip_type(day)
    @precip_probability_percent = get_precip_probability_percent(day)
    @high_temp_F = get_high_temp_F(day)
    @low_temp_F = get_low_temp_F(day)
  end

  private

  attr_reader :day

  def get_day_of_week(day)
    Time.at(day[:time]).strftime('%A')
  end

  def get_unix_timestamp(day)
    day[:time]
  end

  def get_weather_icon(day)
    day[:icon]
  end

  def get_precip_type(day)
    day[:precipType]
  end

  def get_precip_probability_percent(day)
    (day[:precipProbability] * 100).to_i
  end

  def get_high_temp_F(day)
    (day[:temperatureMax]).round
  end

  def get_low_temp_F(day)
    (day[:temperatureMin]).round
  end
end
